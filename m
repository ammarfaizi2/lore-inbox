Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263217AbRE2G3H>; Tue, 29 May 2001 02:29:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263224AbRE2G25>; Tue, 29 May 2001 02:28:57 -0400
Received: from gec.gecpalau.com ([206.49.60.67]:39512 "EHLO gec.gecpalau.com")
	by vger.kernel.org with ESMTP id <S263217AbRE2G2r>;
	Tue, 29 May 2001 02:28:47 -0400
Message-ID: <3B134260.1030309@gecpalau.com>
Date: Tue, 29 May 2001 15:32:00 +0900
From: Glenn Shannon <glenn@gecpalau.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.5-ac2-WARKERN i686; en-US; 0.8.1) Gecko/20010421
X-Accept-Language: en
MIME-Version: 1.0
To: Anton Voloshin <vav@isv.ru>
CC: linux-kernel@vger.kernel.org
Subject: Re: BUG REPORT: 2.4.4 hang on large network transfers with RTL-8139
In-Reply-To: <20010529142019.C757@ws17.krasu.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Voloshin wrote:

> Hello,
> 
> I've got a kernel hang (can easily be reproduced on my computer).
> It happens on relatively large outgoing network traffic.
> For instance, on trying to upload some large file from workstation to
> other machine via SMB or FTP.
> 
> On 2.4.4 hang was after sending about 20Kb.
> On 2.4.5 it seems to hang after 870+ Kb.
> When sending data via slow link (e.g. local Ethernet -> remote modem),
> everything is Ok.
> 
> Network card is (taken from /proc/pci):
> 
>   Bus  1, device  11, function  0:
>     Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139 (rev 16).
>       IRQ 10.
>       Master Capable.  Latency=208.  Min Gnt=32.Max Lat=64.
>       I/O at 0x7800 [0x78ff].
>       Non-prefetchable 32 bit memory at 0xfebfff00 [0xfebfffff].
> 
> 2.4.3 works Ok, 2.4.4 and 2.4.5 both has this problem.
> 
> Lamer's assumption: maybe troubles with sendfile() after zero-copy patches?
> 
Actually I get the same problem (I kind of have to run 2.4.5-ac2 
however). I just try not to download or upload large files over fast links.

Glenn Shannon

