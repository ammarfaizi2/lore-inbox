Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264879AbSKEPwF>; Tue, 5 Nov 2002 10:52:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264880AbSKEPwF>; Tue, 5 Nov 2002 10:52:05 -0500
Received: from ns1.alcove-solutions.com ([212.155.209.139]:2021 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S264879AbSKEPwD>; Tue, 5 Nov 2002 10:52:03 -0500
Date: Tue, 5 Nov 2002 16:58:36 +0100
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Manuel Serrano <Manuel.Serrano@sophia.inria.fr>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-pre10-ac2, Sony PCG-C1MHP and Sonypi
Message-ID: <20021105155836.GE12610@tahoe.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	Manuel Serrano <Manuel.Serrano@sophia.inria.fr>,
	linux-kernel@vger.kernel.org
References: <20021105104620.7c1282fa.Manuel.Serrano@sophia.inria.fr> <20021105151540.GB12610@tahoe.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021105151540.GB12610@tahoe.alcove-fr>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 05, 2002 at 04:15:40PM +0100, Stelian Pop wrote:

> > Incompatibility between USB and SONYPI.
> > 
> > [2.] Full description of the problem/report:
> > ============================================
> > 
> > Sonypi and USB modules seems to be incompatible. That is, if I don't load
> > any USB kernel modules, using Sonypi works perfectly (I mostly use it
> > to access the LCD brightness). 
> 
> Does this mean that you can use it to get jogdial or Fn keys events too ?
> 
> > If I load USB modules, then Sonypi reports
> > errors:
> 
> Please send me (off list)  a copy of your dissassambled ACPI bios(*)
> and I'll take a look at it.

After seing your ACPI bios I cannot find out the reason why it 
interferes with the USB subsystem.

The failed commands happen when sonypi tries to access the 0x62
and 0x66 ports, which are (wrongly) reserved by the keyboard 
(this is why sonypi cannot reserve them). These registers are
also used by ACPI 'Embedded Controller'.

But I still cannot understand what the USB does in this area.

You didn't say if you compiled in the ACPI susbystem. Does it
change something if you do not compile it (in case you did
previously) or if you do compile it (in case you didn't) ?

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
