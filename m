Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269568AbUJSScK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269568AbUJSScK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 14:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269654AbUJSS1P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 14:27:15 -0400
Received: from mail.scitechsoft.com ([63.195.13.67]:53736 "EHLO
	mail.scitechsoft.com") by vger.kernel.org with ESMTP
	id S270088AbUJSRzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 13:55:05 -0400
From: "Kendall Bennett" <KendallB@scitechsoft.com>
Organization: SciTech Software, Inc.
To: Richard Smith <rsmith@bitworks.com>
Date: Tue, 19 Oct 2004 10:54:50 -0700
MIME-Version: 1.0
Subject: Re: [Linux-fbdev-devel] Generic VESA framebuffer driver and Video card BOOT?
CC: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
Message-ID: <4174F27A.8234.1645ECBF@localhost>
In-reply-to: <4174704B.9050601@bitworks.com>
References: <41740384.5783.12A07B14@localhost>
X-mailer: Pegasus Mail for Windows (4.21c)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Smith <rsmith@bitworks.com> wrote:

> Kendall Bennett wrote:
> 
> > Actually there is nothing wrong with the x86 BIOS from the perspective of 
> > functionality and useability (or bloat for that matter). It contains all 
> > the functionality we need and armed with something like the x86 emulator 
> > we can use it for what we need on any platform.
> 
> > IMHO that is the best solution to the problem because it will be using 
> > code that has been heavily tested by the vendor. The one thing x86 Video 
> > BIOS'es can do reliably is POST the graphics card ;-)
> 
> I'm just going to take your word on this since you have messed
> with far more video bioses than I.  I've just got a few too many
> scars over the years from trying to make the whole BIOS sub-system
> robust enough for embedded standards. 

Most BIOS'es are relatively good, but there are some terrible ones. We 
have one a lot of work over the years making our VESA VBE drivers work 
well with all the BIOS'es out there, working around the issues in the 
broken ones. I plan to use that same module for the kernel VESA driver 
when I get around to re-writing it.

> > lot of code bloat. But if you do that, then you would need this code in 
> > the kernel since now it would be the boot loader as well ;-)
> 
> Exactly. Which is why I like your project and I think its a good
> thing. The only reason I have to carry around the legacy BIOS
> baggage is for video. 

Yep.

> How big is your in-kernel implementation?

Right now the compiled x86 code is about 100K in size. PowerPC code 
appears to be about twice that size and x86-64 is about 130K I think. I 
have no idea how big an Open Firmware interpreter would be for comparison 
purposes because I have never seen an Open Source implementation of one.

Regards,

---
Kendall Bennett
Chief Executive Officer
SciTech Software, Inc.
Phone: (530) 894 8400
http://www.scitechsoft.com

~ SciTech SNAP - The future of device driver technology! ~


