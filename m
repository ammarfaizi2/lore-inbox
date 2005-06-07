Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261726AbVFGFiJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261726AbVFGFiJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 01:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261725AbVFGFiJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 01:38:09 -0400
Received: from lakermmtao07.cox.net ([68.230.240.32]:63656 "EHLO
	lakermmtao07.cox.net") by vger.kernel.org with ESMTP
	id S261726AbVFGFiA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 01:38:00 -0400
From: "Steve Lee" <steve@tuxsoft.com>
To: "'Dmitry Torokhov'" <dtor_core@ameritech.net>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: Linux v2.6.12-rc6 mouse wheel not working
Date: Tue, 7 Jun 2005 00:36:13 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
In-Reply-To: <200506062140.48723.dtor_core@ameritech.net>
Thread-Index: AcVrAn/opERfD+LnSF6voJjEoCvByAAH21QA
Message-Id: <20050607053759.BJXU28809.lakermmtao07.cox.net@saturn>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is how the mouse is detected under 2.6.11.11 and 2.6.12-rc6:

Linux-2.6.11.11

I: Bus=0011 Vendor=0002 Product=0006 Version=000f
N: Name="ImExPS/2 Logitech Explorer Mouse"
P: Phys=isa0060/serio1/input0
H: Handlers=mouse0 event2
B: EV=7
B: KEY=1f0000 0 0 0 0 0 0 0 0
B: REL=103

Linux-2.6.12-rc6

I: Bus=0011 Vendor=0002 Product=0002 Version=000f
N: Name="PS2++ Logitech MX Mouse"
P: Phys=isa0060/serio1/input0
H: Handlers=mouse1 event2 
B: EV=7 
B: KEY=ff0000 0 0 0 0 0 0 0 0 
B: REL=143 

With the patch you provided, the mouse is once again detected the same as
2.6.11.11 and it works as expected.  I guess my question at this point is,
how do I get the new code to work correctly?

Thanks,
Steve



-----Original Message-----
From: Dmitry Torokhov [mailto:dtor_core@ameritech.net] 
Sent: Monday, June 06, 2005 9:41 PM
To: linux-kernel@vger.kernel.org
Cc: Steve Lee
Subject: Re: Linux v2.6.12-rc6 mouse wheel not working

On Monday 06 June 2005 20:11, Steve Lee wrote:
> I've been using 2.6.11.11 just fine, but I thought I'd give 2.6.12-rc6 a
> test run.  With 2.6.11.11, my mouse works as expected (wheel works fine),
> however, 2.6.12-rc6 this is not true.  I saw there were some changes with
> regards to the mouse, and it's apparent these changes have affected my
> system in a negative way.  I have the Logitech MX 1000 connected to a
Belkin
> OnmiCube switch via PS2.  Please CC me as I'm not a subscriber to this
list.
> I'd be more than happy to test any possible fixes.  Oh, this is on a Linux
> From Scratch 6.0 (w/BLFS updates) system with dual athlon MPs.
>

Is there a difference in how kernel identifies your mouse? MX 1000-specific
support was introduced in 2.6.12...  

Does it help if you revert the following patch:

http://linux.bkbits.net:8080/linux-2.5/gnupatch%4042038820Zbz0cXacn-y2xfuPP_
JqIw
 
-- 
Dmitry




