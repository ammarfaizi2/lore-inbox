Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313628AbSGTI4g>; Sat, 20 Jul 2002 04:56:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314602AbSGTI4g>; Sat, 20 Jul 2002 04:56:36 -0400
Received: from aboukir-101-1-23-willy.adsl.nerim.net ([62.212.114.60]:57606
	"EHLO www.home.local") by vger.kernel.org with ESMTP
	id <S313628AbSGTI4g>; Sat, 20 Jul 2002 04:56:36 -0400
Date: Sat, 20 Jul 2002 10:54:21 +0200
From: Willy Tarreau <willy@w.ods.org>
To: harish.vasudeva@amd.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: need help with SIOCSIFFLAGS..
Message-ID: <20020720085421.GA3672@alpha.home.local>
References: <CB35231B9D59D311B18600508B0EDF2F04F28515@caexmta9.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CB35231B9D59D311B18600508B0EDF2F04F28515@caexmta9.amd.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  when i try to bind my network driver with : ifconfig eth0 IP netmask MASK, i get this msg:
> 
> SIOCSIFFLAGS : Resource Temporarily Unavailable
> 
>  any ideas why this occurs? where can i get additional info on this?

May be the I/O ports and/or the IRQ are in use by another device at
the time you do this. ifconfig also sets the device up, so the driver
will try to reserve resources. Isn't this an ISA card bound to IRQ 3
while your COM2 is being used, for example ?

Regards,
Willy

