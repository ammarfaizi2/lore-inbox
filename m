Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318085AbSGWPDc>; Tue, 23 Jul 2002 11:03:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318094AbSGWPDb>; Tue, 23 Jul 2002 11:03:31 -0400
Received: from chaos.analogic.com ([204.178.40.224]:24705 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S318085AbSGWPD2>; Tue, 23 Jul 2002 11:03:28 -0400
Date: Tue, 23 Jul 2002 11:08:43 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Tibor Veres <infrared@webigen.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: problems on crusoe-based laptop
In-Reply-To: <1027435810.26534.28.camel@infrared>
Message-ID: <Pine.LNX.3.95.1020723110023.21799A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 Jul 2002, Tibor Veres wrote:

> I'm trying to install linux to a toshiba libretto l5 (transmeta crusoe
> TM5800). 
> 
> I have no cd or floppy, I boot over the network with intel pxe bootrom..
> DHCP works, after stripping down the kernel to <512k, the kernel loads
> too, but I get the following error message: 
> 

> AX: 0205
       | |_______ 5 sectors
       |_________ Read command

> BX: 0200
         |_______ Buffer is at offset 0x200       
> CX: 0020
       | |_______ Sector number 0x20
       |_________ Track  number 0
> DX: 0000.
       |_________ Drive 0 (Floppy disk 0)
> 8000
   | |___________ NR sectors read (0)
   |_____________ Reason (no device or no interrupt)
> 


Well it's trying to read from a floppy that doesn't exist. The
read code is from the boot-loader that is usually executed by
LILO (wrong boot-code for network booting).


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

