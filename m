Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751730AbWBQUY0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751730AbWBQUY0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 15:24:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751720AbWBQUYZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 15:24:25 -0500
Received: from wproxy.gmail.com ([64.233.184.195]:7038 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751715AbWBQUYY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 15:24:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YagHZiQ0/lcjbffwRVuIk+eagBUm9QHMKHP26IdtqDzw8tQBXGl7Vvg0M9D+GZvO92OK2svvpr589PyXCYNKjFrPHfig0/AsVkuE5Mwao6i0kpNI/kcn/86GbKCNx/Jw3l2bdsMw0JtDpb2Q1g9IVXThRnTgAS7yERwTeg6AHps=
Message-ID: <7c3341450602171224y5eba2095o@mail.gmail.com>
Date: Fri, 17 Feb 2006 20:24:23 +0000
From: Nick Warne <nick@linicks.net>
Reply-To: Nick Warne <nick@linicks.net>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Subject: Re: C/H/S from user space
Cc: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>,
       Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0602171452520.4290@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.61.0602171157140.8950@chaos.analogic.com>
	 <43F617FA.2030609@wolfmountaingroup.com>
	 <Pine.LNX.4.61.0602171452520.4290@chaos.analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > So, since Linux doesn't destroy that information remaining in
> the BIOS tables, I show how to make it available to a 'root' user.
> Observation over several machines will show that the BIOS always
> uses the same stuff for large media and, in fact, it has no choice.
> Basically, this means that the first part of the boot-code, the
> stuff that needs to be translated to fit into the int 0x13 registers,
> needs to be below 1024 cylinders, 63 sectors-track, and 256 heads.
> Trivial... even LILO was able to do that! Once the machine boots
> past the requirement to use the BIOS services, it's a CHS=NOP.


If I am off the mark here, forgive me.

Since I moved exclusively to GNU/Linux 2 years ago, I notice when I
update kernel I get this:

nick@linuxamd:nick$ sudo /sbin/lilo -v
LILO version 22.5.9, Copyright (C) 1992-1998 Werner Almesberger
Development beyond version 21 Copyright (C) 1999-2004 John Coffman
Released 08-Apr-2004 and compiled at 00:18:50 on May 21 2004.

Warning: LBA32 addressing assumed
Reading boot sector from /dev/hda2
Warning: Kernel & BIOS return differing head/sector geometries for device 0x80
    Kernel: 65535 cylinders, 16 heads, 63 sectors
      BIOS: 1024 cylinders, 255 heads, 63 sectors
Warning: Kernel & BIOS return differing head/sector geometries for device 0x81
    Kernel: 29777 cylinders, 16 heads, 63 sectors
      BIOS: 1024 cylinders, 255 heads, 63 sectors

Now, from day one I never used the -v option with lilo, but as I get
more experienced (!) I do now and see the above... I have never
investigated due to worrying if I start messing with it I will trash
my disks - as I see all anyway on this disks (and no errors), all
works great/fast etc.

Is this what is going on here (re this thread?).

Nick
