Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261740AbVFGFtw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261740AbVFGFtw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 01:49:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261750AbVFGFtw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 01:49:52 -0400
Received: from smtp804.mail.sc5.yahoo.com ([66.163.168.183]:16978 "HELO
	smtp804.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261740AbVFGFtn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 01:49:43 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: "Steve Lee" <steve@tuxsoft.com>
Subject: Re: Linux v2.6.12-rc6 mouse wheel not working
Date: Tue, 7 Jun 2005 00:49:34 -0500
User-Agent: KMail/1.8.1
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>
References: <20050607053759.BJXU28809.lakermmtao07.cox.net@saturn>
In-Reply-To: <20050607053759.BJXU28809.lakermmtao07.cox.net@saturn>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506070049.35425.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 June 2005 00:36, Steve Lee wrote:
> Here is how the mouse is detected under 2.6.11.11 and 2.6.12-rc6:
> 
> Linux-2.6.11.11
> 
> I: Bus=0011 Vendor=0002 Product=0006 Version=000f
> N: Name="ImExPS/2 Logitech Explorer Mouse"
> P: Phys=isa0060/serio1/input0
> H: Handlers=mouse0 event2
> B: EV=7
> B: KEY=1f0000 0 0 0 0 0 0 0 0
> B: REL=103
> 
> Linux-2.6.12-rc6
> 
> I: Bus=0011 Vendor=0002 Product=0002 Version=000f
> N: Name="PS2++ Logitech MX Mouse"
> P: Phys=isa0060/serio1/input0
> H: Handlers=mouse1 event2 
> B: EV=7 
> B: KEY=ff0000 0 0 0 0 0 0 0 0 
> B: REL=143 
> 
> With the patch you provided, the mouse is once again detected the same as
> 2.6.11.11 and it works as expected.  I guess my question at this point is,
> how do I get the new code to work correctly?
>

Could you please compile evbug module, insert it into unpatched 2.6.12-rc6
and try scrolling the wheel - I want to see what events the driver emits.

I am also CC-in Vojtech Pavlik - he may have some insights as to why MX1000
wheel is not working.
 
> Thanks,
> Steve
> 
> 
> 
> -----Original Message-----
> From: Dmitry Torokhov [mailto:dtor_core@ameritech.net] 
> Sent: Monday, June 06, 2005 9:41 PM
> To: linux-kernel@vger.kernel.org
> Cc: Steve Lee
> Subject: Re: Linux v2.6.12-rc6 mouse wheel not working
> 
> On Monday 06 June 2005 20:11, Steve Lee wrote:
> > I've been using 2.6.11.11 just fine, but I thought I'd give 2.6.12-rc6 a
> > test run.  With 2.6.11.11, my mouse works as expected (wheel works fine),
> > however, 2.6.12-rc6 this is not true.  I saw there were some changes with
> > regards to the mouse, and it's apparent these changes have affected my
> > system in a negative way.  I have the Logitech MX 1000 connected to a
> Belkin
> > OnmiCube switch via PS2.  Please CC me as I'm not a subscriber to this
> list.
> > I'd be more than happy to test any possible fixes.  Oh, this is on a Linux
> > From Scratch 6.0 (w/BLFS updates) system with dual athlon MPs.
> >
> 
> Is there a difference in how kernel identifies your mouse? MX 1000-specific
> support was introduced in 2.6.12...  
> 
> Does it help if you revert the following patch:
> 
> http://linux.bkbits.net:8080/linux-2.5/gnupatch%4042038820Zbz0cXacn-y2xfuPP_
> JqIw
>  

-- 
Dmitry
