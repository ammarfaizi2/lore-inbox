Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292350AbSB0PMe>; Wed, 27 Feb 2002 10:12:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292565AbSB0PMX>; Wed, 27 Feb 2002 10:12:23 -0500
Received: from mail.shorewall.net ([206.124.146.177]:8208 "EHLO
	mail.shorewall.net") by vger.kernel.org with ESMTP
	id <S292581AbSB0PMJ>; Wed, 27 Feb 2002 10:12:09 -0500
From: "Tom Eastep" <teastep@shorewall.net>
To: <bernat@free.fr>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: VIA Northbridge Workaround in 2.4.18 Causing Video Problems
Date: Wed, 27 Feb 2002 07:12:09 -0800
Organization: Shoreline Firewall
Message-ID: <000001c1bfa1$20759060$0501a8c0@ursa>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
In-Reply-To: <m3u1s4asb4.fsf@neo.loria>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vincent,

> -----Original Message-----
> From: bernat@free.fr [mailto:bernat@free.fr] 
> Sent: Tuesday, February 26, 2002 12:42 PM
> To: Tom Eastep
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: VIA Northbridge Workaround in 2.4.18 Causing 
> Video Problems
>
> Tom Eastep <teastep@shorewall.net> disait:
> 
> 
> > I'm currently getting around the problem with the following hack:
> 
> You may use the "setpci" command instead to fix this in "userland".
> 

Thanks for the suggestion -- unfortunately, it is only a partial
solution.

During boot with an 80x25 VGA console, the console video is getting
trashed even before the first init script runs. In that case, correcting
the root cause (setting bit 5 in byte 0x55 of the Northbridge config)
does nothing to restore console video (although it does allow X to run
properly). 

So long as I am running a kernel that includes my hack, there's no
problem. My main concern is that the next time that people with a system
like mine want to upgrade their distribution, the distribution's kernel
will include this workaround; those people (myself included) will then
have a miserable time doing the upgrade. 

-Tom
--
Tom Eastep   \ Shorewall -- iptables made easy
AIM: tmeastep \ http://www.shorewall.net
ICQ: #60745924 \ teastep@shorewall.net 


 

