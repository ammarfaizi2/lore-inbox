Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311355AbSCLVwh>; Tue, 12 Mar 2002 16:52:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311356AbSCLVw2>; Tue, 12 Mar 2002 16:52:28 -0500
Received: from jffdns02.or.intel.com ([134.134.248.4]:59890 "EHLO
	hebe.or.intel.com") by vger.kernel.org with ESMTP
	id <S311355AbSCLVwI>; Tue, 12 Mar 2002 16:52:08 -0500
Message-ID: <59885C5E3098D511AD690002A5072D3C02AB7CDD@orsmsx111.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Patrick Mochel'" <mochel@osdl.org>
Cc: "'Mario 'BitKoenig' Holbe'" <Mario.Holbe@RZ.TU-Ilmenau.DE>,
        Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: RE: [patch] ACPI: kbd-pw-on/WOL don't work anymore since 2.4.14
Date: Tue, 12 Mar 2002 13:51:57 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Patrick Mochel [mailto:mochel@osdl.org]
> It seems like this would ideally be specified in the config 
> file for the 
> power management agent. So, before the transition to sleep began, the 
> agent would enable those devices to wake the system (probably 
> by writing a 
> value to a driverfs file). 

Agree.

> The only thing is that you probably want all devices of a 
> particular class 
> to wake a system - like all keyboards or all net devices. I 
> don't know 
> what the config file format for ospmd looks like, but it 
> might articulated 
> like:
> 
> /* devices to wake the system when we go to sleep */
> wake {
> 	keyboard
> 	network
> 	mouse
> }
> Right?

Sounds OK to me. Once the wake capability and class of a device are both
visible through driverfs, implementing functionality like this in userspace
is easy.

Regards -- Andy
