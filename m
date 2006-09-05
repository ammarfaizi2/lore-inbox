Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965055AbWIEI6V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965055AbWIEI6V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 04:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965057AbWIEI6V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 04:58:21 -0400
Received: from cantor.suse.de ([195.135.220.2]:10666 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S965055AbWIEI6T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 04:58:19 -0400
From: Andreas Schwab <schwab@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Steven Whitehouse <swhiteho@redhat.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org,
       Russell Cattelan <cattelan@redhat.com>,
       David Teigland <teigland@redhat.com>, hch@infradead.org
Subject: Re: [PATCH 07/16] GFS2: Directory handling
References: <1157031298.3384.797.camel@quoit.chygwyn.com>
	<Pine.LNX.4.61.0609041314470.21005@yvahk01.tjqt.qr>
	<1157445854.3384.965.camel@quoit.chygwyn.com>
	<20060905084334.GA16788@elte.hu>
X-Yow: Yow!  It's a hole all the way to downtown Burbank!
Date: Tue, 05 Sep 2006 10:58:07 +0200
In-Reply-To: <20060905084334.GA16788@elte.hu> (Ingo Molnar's message of "Tue,
	5 Sep 2006 10:43:34 +0200")
Message-ID: <je3bb6zo4g.fsf@sykes.suse.de>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> writes:

> * Steven Whitehouse <swhiteho@redhat.com> wrote:
>
>> > >+static inline int __gfs2_dirent_find(const struct gfs2_dirent *dent,
>> > >+				     const struct qstr *name, int ret)
>> > >+{
>> > >+	if (dent->de_inum.no_addr != 0 &&
>> > >+	    be32_to_cpu(dent->de_hash) == name->hash &&
>> > >+	    be16_to_cpu(dent->de_name_len) == name->len &&
>> > >+	    memcmp((char *)(dent+1), name->name, name->len) == 0)
>> > 
>> > Nocast.
>> > 
>> ok
>
> actually, sizeof(*dent) != 1, so how can a non-casted memcmp be correct 
> here?

How can the cast change anything?

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
