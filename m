Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264854AbSK0VeC>; Wed, 27 Nov 2002 16:34:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264857AbSK0VeB>; Wed, 27 Nov 2002 16:34:01 -0500
Received: from chaos.analogic.com ([204.178.40.224]:18560 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S264854AbSK0VeA>; Wed, 27 Nov 2002 16:34:00 -0500
Date: Wed, 27 Nov 2002 16:41:18 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Chris Friesen <cfriesen@nortelnetworks.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: how to list pci devices from userpace?  anything better than /proc/bus/pci/devices?
In-Reply-To: <3DE537FC.6090105@nortelnetworks.com>
Message-ID: <Pine.LNX.3.95.1021127163510.4690A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Nov 2002, Chris Friesen wrote:

> 
> I have a situation where the userspace app needs to be able to deal with 
>   two different models of hardware, each of which uses a slightly 
> different api.
> 
> Is there any way that I can query the pci vendor/device numbers without 
> having to parse ascii files in /proc?
> 
> Thanks,
> 
> Chris

Red Hat distributions after 7.0 provide `lspci`. You still have
to parse ASCII. FYI, it's not hard to write a 'C' program
that directly accessed the PCI bus from its ports at 0xCF8 (index)
and 0xCFC (data). You need to do 32-bit port accesses and you
can set iopl(3) from user-space.

If you want to 'roll-your-own', I can send you some code to
use as a template.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
   Bush : The Fourth Reich of America


