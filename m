Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263728AbTIBVox (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 17:44:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263752AbTIBVox
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 17:44:53 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:11538 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263728AbTIBVog (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 17:44:36 -0400
Date: Tue, 2 Sep 2003 22:44:33 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: kernel <linux-kernel@vger.kernel.org>
Subject: Re: Same problem with pcmcia in 2.4.22 as in 2.6.0-test4
Message-ID: <20030902224433.F9345@flint.arm.linux.org.uk>
Mail-Followup-To: kernel <linux-kernel@vger.kernel.org>
References: <1061936739.10642.6.camel@garaged.fis.unam.mx> <20030826223405.GA2746@iain-vaio-fx405> <20030831121019.GB22771@iain-vaio-fx405> <20030831133846.C3017@flint.arm.linux.org.uk> <20030902203043.GA12997@iain-vaio-fx405>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030902203043.GA12997@iain-vaio-fx405>; from ibroadfo@cis.strath.ac.uk on Tue, Sep 02, 2003 at 09:30:43PM +0100
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 02, 2003 at 09:30:43PM +0100, iain d broadfoot wrote:
> * Russell King (rmk@arm.linux.org.uk) wrote:
> > On Sun, Aug 31, 2003 at 01:10:20PM +0100, iain d broadfoot wrote:
> > > Hallo again,
> > > 
> > > Just wondering if anyone has any insights into what's going wrong with
> > > my pcmcia in both 2.4.22 and 2.6.0-test4.
> > > 
> > > orinoco_cs: RequestIRQ: Resource in use
> > > 
> > > is the error I get on inserting my wireless card.
> > 
> > There's a patch on pcmcia.arm.linux.org.uk for 2.6.0-test4 which gets
> > some more information about what went wrong.  Could you apply it and
> > report the kernel messages please?
> 
> the output the patch should've sent didn't show up in dmesg at all...
> 
> I had the same error message as before.

Oh dear.

> does that indicate anything helpful?

It could mean one of two things - either we don't have any interrupts
available at all, or orinoco already claimed its interrupt before...

Could you try the updated debugging patch there please?  It should
print something extra no matter what.

Could you also provide the kernel messages which include the
initialisation of your PCMCIA or CardBus bridge please?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

