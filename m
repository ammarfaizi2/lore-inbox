Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751415AbWIELGG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751415AbWIELGG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 07:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751422AbWIELGF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 07:06:05 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:9174 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751415AbWIELGB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 07:06:01 -0400
Date: Tue, 5 Sep 2006 12:58:13 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andreas Schwab <schwab@suse.de>
Cc: Steven Whitehouse <swhiteho@redhat.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org,
       Russell Cattelan <cattelan@redhat.com>,
       David Teigland <teigland@redhat.com>, hch@infradead.org
Subject: Re: [PATCH 07/16] GFS2: Directory handling
Message-ID: <20060905105813.GA8195@elte.hu>
References: <1157031298.3384.797.camel@quoit.chygwyn.com> <Pine.LNX.4.61.0609041314470.21005@yvahk01.tjqt.qr> <1157445854.3384.965.camel@quoit.chygwyn.com> <20060905084334.GA16788@elte.hu> <je3bb6zo4g.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <je3bb6zo4g.fsf@sykes.suse.de>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andreas Schwab <schwab@suse.de> wrote:

> >> > >+	if (dent->de_inum.no_addr != 0 &&
> >> > >+	    be32_to_cpu(dent->de_hash) == name->hash &&
> >> > >+	    be16_to_cpu(dent->de_name_len) == name->len &&
> >> > >+	    memcmp((char *)(dent+1), name->name, name->len) == 0)
> >> > 
> >> > Nocast.
> >> > 
> >> ok
> >
> > actually, sizeof(*dent) != 1, so how can a non-casted memcmp be correct 
> > here?
> 
> How can the cast change anything?

yeah - i for a minute thought that the '+' is outside the cast - but it 
is inside.

	Ingo
