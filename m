Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318425AbSGYLqC>; Thu, 25 Jul 2002 07:46:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318427AbSGYLqA>; Thu, 25 Jul 2002 07:46:00 -0400
Received: from babyruth.hotpop.com ([204.57.55.14]:49085 "EHLO
	babyruth.hotpop.com") by vger.kernel.org with ESMTP
	id <S318425AbSGYLp7> convert rfc822-to-8bit; Thu, 25 Jul 2002 07:45:59 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Mike Insch <vofka@hotpop.com>
Reply-To: vofka@hotpop.com
To: linux-kernel@vger.kernel.org
Subject: Oddities with HighPoint HPT374, 2.4.19-pre10-ac2
Date: Thu, 25 Jul 2002 12:49:02 +0100
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200207251249.02531.vofka@hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a system with an ABIT AT7 Motherboard (Duron 1200, 256MB PC2100 RAM), 
and have 8 80GB Maxtor IDE HDD's connected to the HPT374 controller on the 
board, configured as a single RAID-0 Array in hardware.

When copying data from another disk connected to the VIA IDE Controller, the 
kernel oopses with an 'Unable to handle NULL pointer dereference at virtual 
address 00000004' after about 5MB has copied.  The process implicated by the 
oops is the kjournald process for the only partition on the RAID array.

Sorry I have no output from the oops - it locks totally, and the oops is never 
logged :(

Copying large amounts of data from a Samba Share on the network (over 15GB!) 
has produced no similar problems - so I'm guessing that kjournald, or the 
HPT374 drivers don't like the 640GB array when data is being committed too 
fast. (All the drives involved are UDMA 133 Drives, both the one on the VIA 
Controller, and all 8 on the HPT Controller).

I know it's hard to say without me giving more info, but does anyone have any 
idea what could possibly cause this?  Have there been updates in newer 
releases to either the HPT374 Code, or to the kjournald code that could solve 
this?  Is it worth me getting and compiling 2.4.19-rc3-ac3 to see if the 
problem is solved there?  Any and all info. which may help tracking down this 
gremlin would be greatly appreciated....

(I can post detailed info. about the hardware (lspci, dmesg etc), and kernel 
configurations if that would be of any use?)


