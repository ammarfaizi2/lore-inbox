Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261276AbTLPJE3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 04:04:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261298AbTLPJE3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 04:04:29 -0500
Received: from smtp14.fre.skanova.net ([195.67.227.31]:46039 "EHLO
	smtp14.fre.skanova.net") by vger.kernel.org with ESMTP
	id S261276AbTLPJE1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 04:04:27 -0500
Message-ID: <3FDECA96.8050603@ida.liu.se>
Date: Tue, 16 Dec 2003 10:04:22 +0100
From: Ola Leifler <olale@ida.liu.se>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031020 Debian/1.5-1
X-Accept-Language: sv, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Ola Leifler <olale@ida.liu.se>
Subject: Re: PROBLEM: siimage.o on AMD768 platform
References: <3FDEC5BE.2070200@ida.liu.se>
In-Reply-To: <3FDEC5BE.2070200@ida.liu.se>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ola Leifler wrote:

> Hi!
> [Formatted according to 
> http://www.kernel.org/pub/linux/docs/lkml/reporting-bugs.html]
> 1. Brief description:
> My Silicon Image 3112A controller doesn't recognize any of the two 
> Seagate 7200.7 80Gb discs attached to it. Neither do the ide2/ide3 
> interfaces show up in /proc, according to the information below.
>
> 2. Full description:
> When using siimage.o  to access a  dual channel Serial ATA controller 
> with a Silicon Image 3112 chipset, none of the two hard discs are 
> detected (No program can access /dev/hd[e-h]). However, the module 
> refuses to unload (device busy).  During boot, the card BIOS lists 
> both discs.

Some additional information which may or may not be of any assistance to 
Andre or Alan:

There doesn't seem to be any device on interrupt 19 though lspci -vvv 
suggested that.

# cat /proc/interrupts
           CPU0       CPU1      
  0:     234977     236815    IO-APIC-edge  timer
  1:       6117       6152    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  8:          3          1    IO-APIC-edge  rtc
 12:      87594      88013    IO-APIC-edge  PS/2 Mouse
 14:          9         20    IO-APIC-edge  ide0
 15:        204        269    IO-APIC-edge  ide1
 16:     179228     178555   IO-APIC-level  nvidia
 17:      15291      15367   IO-APIC-level  sym53c8xx, eth0, CMI8738-MC6
 18:      19569      19540   IO-APIC-level  eth1
NMI:          0          0
LOC:     471710     471740
ERR:          0
MIS:          0
# cat /proc/devices   
Character devices:
  1 mem
  2 pty/m%d
  3 pty/s%d
  4 tts/%d
  5 cua/%d
  7 vcs
 10 misc
 14 sound
 21 sg
 89 i2c
116 alsa
128 ptm
136 pts/%d
162 raw
195 nvidia

Block devices:
  1 ramdisk
  3 ide0
  8 sd
 11 sr
 22 ide1
 65 sd
 66 sd

/Ola


