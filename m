Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267292AbTAGMDi>; Tue, 7 Jan 2003 07:03:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267303AbTAGMDi>; Tue, 7 Jan 2003 07:03:38 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:54662
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267292AbTAGMDh>; Tue, 7 Jan 2003 07:03:37 -0500
Subject: Re: 'D' processes on a healthy system?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: martin f krafft <madduck@debian.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030107080135.GA21307@fishbowl.madduck.net>
References: <20021219124043.GA28617@fishbowl.madduck.net>
	 <1040319832.28973.4.camel@irongate.swansea.linux.org.uk>
	 <20021219182359.GA29366@fishbowl.madduck.net>
	 <1040326031.28973.23.camel@irongate.swansea.linux.org.uk>
	 <20030107080135.GA21307@fishbowl.madduck.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1041944228.20658.15.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 07 Jan 2003 12:57:08 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-01-07 at 08:01, martin f krafft wrote:
> 
> correct me if i am wrong, but it is properly tweaked. moreover, lspci
> shows that there is a VT82C598 [Apollo MVP3] VIA Chipset in there, and
> my kernel config is optimized for that:

Looks good yes.

	hdparm -t will give you the raw disk speed 

> and performance is ridiculous. rsync will transfer about 40k before
> the rsync process enters 'D' state as shown by top. this takes about
> 10 seconds, then rsync gets to transfer another 40k.
> 
> this is on an AMD K6-2 500 MHz machine with 160 Mb RAM, 256Mb of swap
> and a Maxtor 10Gb drive spinning at 5,400 I believe.
> 
> What's the problem?

No idea. strace the rsync see what its spending its time stuck doing 
(eg read from disk, or write to net etc). It'll probably show read from
disk if this is a disk problem

