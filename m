Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316976AbSF0VNy>; Thu, 27 Jun 2002 17:13:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316977AbSF0VNx>; Thu, 27 Jun 2002 17:13:53 -0400
Received: from fed1mtao02.cox.net ([68.6.19.243]:29427 "EHLO
	fed1mtao02.cox.net") by vger.kernel.org with ESMTP
	id <S316976AbSF0VNw>; Thu, 27 Jun 2002 17:13:52 -0400
Message-ID: <3D1B8053.2080806@cox.net>
Date: Thu, 27 Jun 2002 14:14:59 -0700
From: "Kevin P. Fleming" <kpfleming@cox.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.1a) Gecko/20020611
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stanislav Brabec <utx@penguin.cz>
CC: Daniel Nofftz <nofftz@castor.uni-trier.de>, linux-kernel@vger.kernel.org
Subject: Re: another way to activate AMD disconnect on VIA KT266 (aka cooling
 bits)
References: <20020626212659.GA3565@utx.vol.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Same motherboard here (except the Pro2 RU version, with USB 2.0 and 
onboard Promise RAID). Using an Athlon Thunderbird 1GHz, 100MHz FSB 
(10.0 multiplier).

So far looks good, has dropped CPU temp from 52C to 43C in a few 
minutes, and this box is otherwise warm due to having four 7200RPM ATA 
drives and full slots... I don't have ACPI in my kernel, but I do have 
APM (although with only default options turned on).

I have no sound or X stuff on this system, so those things are not a 
problem... I do have a Gigabit Ethernet card, though (NS83820-based), so 
I will be curious if that is affected at all.

Stanislav Brabec wrote:
> Hallo,
> 
> I have been experimenting with AMD disconnect with my VIA KT266 based
> MSI K7T266Pro (MS-6380).
> 
> LVCool does not yet support KT266, method discussed in LKML in past
> (http://cip.uni-trier.de/nofftz/linux/Athlon-Powersaving-HOWTO.html)
> does not activate low power mode on my mainboard. The only bit set by
> this patch is already set probably by BIOS of my motherboard and does
> not help. So I have checked VCool (http://vcool.occludo.net/) & Wine &
> lspci and found following bit changes:
> 
> enable:
> setpci -v -H1 -s 0:0.0 70=86
> setpci -v -H1 -s 0:0.0 95=1e
> disable:
> setpci -v -H1 -s 0:0.0 70=82
> setpci -v -H1 -s 0:0.0 95=1c
> 
> The result is 15 degrees temperature decrease on low system load!
> 
> I don't know exactly, what I am doing (and chipset docs are not
> available), explanation is welcome, (un)success stories for other
> motherboards too.
> 
> It works with both APM and ACPI.
> 
> 

