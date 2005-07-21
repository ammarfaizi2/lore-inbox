Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261793AbVGUPVE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261793AbVGUPVE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 11:21:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261794AbVGUPVD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 11:21:03 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:26604 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261793AbVGUPVC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 11:21:02 -0400
Date: Thu, 21 Jul 2005 17:20:54 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Andreas Steinmetz <ast@domdv.de>,
       Dave Jones <davej@codemonkey.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: amd64-agp vs. swsusp
Message-ID: <20050721152053.GA21475@atrey.karlin.mff.cuni.cz>
References: <42DD67D9.60201@stud.feec.vutbr.cz> <42DD6AA7.40409@domdv.de> <42DD7011.6080201@stud.feec.vutbr.cz> <200507201115.08733.rjw@sisk.pl> <42DECB21.5020903@stud.feec.vutbr.cz> <20050721053126.GB5230@atrey.karlin.mff.cuni.cz> <42DF7C52.4020907@stud.feec.vutbr.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42DF7C52.4020907@stud.feec.vutbr.cz>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >Long time ago there were i386 problems because we assumed that kernel
> >is mapped in one big mapping and agp broke that assumption. Copying
> >pages backwards "fixed" it (and then we done proper fix). It should
> >not be, but it seems similar to this problem....
> 
> Do you mean this patch of yours?:
> http://www.ussg.iu.edu/hypermail/linux/kernel/0404.3/0640.html

Yes.

> I'm trying to do something similar for x86_64. See the attached patch.
> Unfortunately, it doesn't help. The behaviour seems unchanged (resume 
> still works iff amd64-agp wasn't loaded before suspend).

Are you sure problem is on level4_pgt? We probably use constant
level4_pgt but split pages at some deeper level. You may want try
saving 3rd-level table, instead.
								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
