Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136017AbRD0NRe>; Fri, 27 Apr 2001 09:17:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136020AbRD0NRP>; Fri, 27 Apr 2001 09:17:15 -0400
Received: from [208.204.44.103] ([208.204.44.103]:37904 "EHLO
	warpcore.provalue.net") by vger.kernel.org with ESMTP
	id <S136017AbRD0NRM>; Fri, 27 Apr 2001 09:17:12 -0400
Date: Fri, 27 Apr 2001 07:18:09 -0500 (CDT)
From: Collectively Unconscious <swarm@warpcore.provalue.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: BUG: USB/Reboot
In-Reply-To: <E14sAZB-00030T-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.10.10104270709540.735-100000@warpcore.provalue.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Apr 2001, Alan Cox wrote:

> > If USB is disabled on a server works MB reboots hang in 2.2.x
> 
> In almost all cases a hang after Linux reboots the system and it not coming
> back to the BIOS is a BIOS bug.
> 
> You can confirm this by asking the kernel to do a real bios reboot with
> the reboot= option
> 
For those besides me who were wondering where this is documented, 
find . ! -type d ! -type l -exec grep "reboot=" {} \; -print
of /usr/src/linux revealed that it is only documented in
./Documentation/Changes

Here is the pertinant paragraph:

General Information
===================

   <CTRL><ALT><DEL> now performs a cold reboot instead of a warm reboot
for increased hardware compatibility.  If you want a warm reboot and
know it works on your hardware, add a "reboot=warm" command line option
in LILO.  A small number of machines need "reboot=bios" to reboot via
the BIOS.

Note that ./Documentation/kernel-parameters.txt only contains:
    reboot=             [BUGS=ix86]

Jay

