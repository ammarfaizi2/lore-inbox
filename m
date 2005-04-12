Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262440AbVDLMw4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262440AbVDLMw4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 08:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262412AbVDLMsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 08:48:38 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:16587 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S262387AbVDLMr3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 08:47:29 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: [xfs-masters] swsusp vs. xfs [was Re: 2.6.12-rc2-mm1]
Date: Tue, 12 Apr 2005 14:47:20 +0200
User-Agent: KMail/1.7.1
Cc: Nathan Scott <nathans@sgi.com>, "Barry K. Nathan" <barryn@pobox.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       hare@suse.de, linux-xfs@oss.sgi.com
References: <20050406142749.6065b836.akpm@osdl.org> <20050411231213.GD702@frodo> <20050411235110.GA2472@elf.ucw.cz>
In-Reply-To: <20050411235110.GA2472@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504121447.21774.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tuesday, 12 of April 2005 01:51, Pavel Machek wrote:
]--snip--[ 
> > Since the refrigerator() call is in place in the main xfsbufd loop,
> > I suspect we're hitting that second case here, where a low memory
> > situation is resulting in someone attempting to wakeup xfsbufd --
> > I'm not sure if this is the right way to check if we're in that
> > state, but does this patch help?  (it would certainly prevent the
> > spurious wakeups, but only if the caller has PF_FREEZE set - will
> > that be the case here?)
> 
> I should take some sleep now, so I can't test the patch, but I don't
> think it will help. If someone has PF_FREEZE set, he should be in
> refrigerator.

Or he was in TASK_UNINTERRUPTIBLE while processes were being frozen. :-)

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
