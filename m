Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261672AbTCZNIT>; Wed, 26 Mar 2003 08:08:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261674AbTCZNIT>; Wed, 26 Mar 2003 08:08:19 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:30647
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261672AbTCZNIS>; Wed, 26 Mar 2003 08:08:18 -0500
Subject: Re: hdparm and removable IDE?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ron House <house@usq.edu.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3E812F8E.2030200@usq.edu.au>
References: <3E812F8E.2030200@usq.edu.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048689184.31839.7.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 26 Mar 2003 14:33:07 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-03-26 at 04:41, Ron House wrote:
> The scenario: I have a ViPower hot-swap mobile rack for swapping IDE HDs 
> on the fly. I am assuming that this device properly disconnects the 
> hardware and that I am faced with a software problem. Our technical 
> staff tell me that they have 'tested' hot swapping under RedHat 7.3 
> (Kernel 2.4.18-3) and it 'works'. In other words, they unmounted, 
> swapped, and mounted a new disk and didn't observe data loss. I am sure

IDE hotswap at drive level is not supported by Linux. It might work ok. 
Providing you shut the drive down fully and flush the cache before you
unregister/unplug and replug before registering the new interface

> Here are a few other factoids that may be relevant. This utility comes 
> with Windoze drivers to set up hot-swapping. I installed them and they 
> worked, but immediately Partition Magic started crashing Windoze 
> whenever it was run. This behaviour even continued after uninstallation 
> of the hot-swap drivers. Furthermore, at that point Linux started 
> producing lines like this in /var/log/messages:
> 
> Mar 26 13:35:44 Loris kernel: hdd: dma_intr: status=0x51 { DriveReady 
> SeekComplete Error }
> Mar 26 13:35:44 Loris kernel: hdd: dma_intr: error=0x84 { 
> DriveStatusError BadCRC }

Looks like it left the drive misprogrammed

Alan

