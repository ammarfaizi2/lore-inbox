Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267987AbUIGMcp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267987AbUIGMcp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 08:32:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267994AbUIGMco
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 08:32:44 -0400
Received: from legaleagle.de ([217.160.128.82]:62890 "EHLO www.legaleagle.de")
	by vger.kernel.org with ESMTP id S267987AbUIGMcj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 08:32:39 -0400
Date: Tue, 07 Sep 2004 14:32:44 +0200
From: Gunnar Ritter <Gunnar.Ritter@pluto.uni-freiburg.de>
Organization: Privat.
To: =?utf-8?Q?J=C3=B6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Steve French <smfltc@us.ibm.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/3] copyfile: generic_sendpage
Message-ID: <413DAA6C.nailA302391SX@pluto.uni-freiburg.de>
References: <20040904165733.GC8579@wohnheim.fh-wedel.de>
 <20040904153902.6ac075ea.akpm@osdl.org>
 <413C5BF2.nail2RA1138AG@pluto.uni-freiburg.de>
 <20040906133523.GC25429@wohnheim.fh-wedel.de>
 <413C74E6.nail3YF11Y0TT@pluto.uni-freiburg.de>
 <20040907110913.GA25802@wohnheim.fh-wedel.de>
 <20040907114536.GA26630@wohnheim.fh-wedel.de>
 <413DA387.nailA2K1PT2WH@pluto.uni-freiburg.de>
 <20040907120816.GB26972@wohnheim.fh-wedel.de>
In-Reply-To: <20040907120816.GB26972@wohnheim.fh-wedel.de>
User-Agent: nail 11.6pre 9/7/04
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörn Engel <joern@wohnheim.fh-wedel.de> wrote:

> On Tue, 7 September 2004 14:03:19 +0200, Gunnar Ritter wrote:
> > 			if (count == 0) {
> > 				done = -1;
> > 				errno = EINTR; [...]
> Is that really needed? If in_file->f_op->sendfile() returns some
> error, it's already handled above.  If it returns 0, done remains 0
> and we return 0, indicating EOF.  And the check for pending signals
> happens after handling the first chunk, so -EINTR shouldn't be
> necessary.

Yes, this was obviously not the correct location for the check then.

	Gunnar
