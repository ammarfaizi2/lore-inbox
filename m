Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267974AbUIGMIs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267974AbUIGMIs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 08:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267971AbUIGMIr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 08:08:47 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:59304 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S267958AbUIGMHr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 08:07:47 -0400
Date: Tue, 7 Sep 2004 14:04:06 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Gunnar Ritter <Gunnar.Ritter@pluto.uni-freiburg.de>
Cc: Steve French <smfltc@us.ibm.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/3] copyfile: generic_sendpage
Message-ID: <20040907120406.GA26972@wohnheim.fh-wedel.de>
References: <20040904165733.GC8579@wohnheim.fh-wedel.de> <20040904153902.6ac075ea.akpm@osdl.org> <413C5BF2.nail2RA1138AG@pluto.uni-freiburg.de> <20040906133523.GC25429@wohnheim.fh-wedel.de> <413C74E6.nail3YF11Y0TT@pluto.uni-freiburg.de> <20040907110913.GA25802@wohnheim.fh-wedel.de> <413DA026.nail9XE11008R@pluto.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <413DA026.nail9XE11008R@pluto.uni-freiburg.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 September 2004 13:48:54 +0200, Gunnar Ritter wrote:
> Jörn Engel <joern@wohnheim.fh-wedel.de> wrote:
> 
> > Add another loop in the userspace caller to deal with it, if you don't
> > already have it. It's a valid and documented return value, after all.
> 
> Of course (although cp will be terminated by the SIGINT anyway, so it
> does not matter in this situation).

I tested by hitting Ctrl-z.  My admittedly stupid test program didn't
have a loop, so the fg terminated it. :)

> Do I understand this correctly that sendfile now behaves like write with
> SA_RESTART not set for the signal?

Yes.

> If so, it might perhaps make sense to
> add SA_RESTART semantics too, so that sendfile then just continues if the
> process catches the signal and does not abort (scenario: SIGWINCH is sent
> to a curses-based file manager).

It might, not sure.  I've never actually looked at it, never missed
it, don't need it.  Maybe someone else has a strong feeling one way or
the other?

Jörn

-- 
He who knows others is wise.
He who knows himself is enlightened.
-- Lao Tsu
