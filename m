Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266941AbTBTTvq>; Thu, 20 Feb 2003 14:51:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266944AbTBTTvq>; Thu, 20 Feb 2003 14:51:46 -0500
Received: from 251.017.dsl.syd.iprimus.net.au ([210.50.55.251]:13238 "EHLO
	file1.syd.nuix.com.au") by vger.kernel.org with ESMTP
	id <S266941AbTBTTvo> convert rfc822-to-8bit; Thu, 20 Feb 2003 14:51:44 -0500
Content-Type: text/plain; charset=US-ASCII
From: Song Zhao <song.zhao@nuix.com.au>
Reply-To: song.zhao@nuix.com.au
Organization: Nuix
To: Manish Lachwani <manish@Zambeel.com>
Subject: Re: Supermicro X5DL8-GG (ServerWorks Grandchampion LE chipset) sl ow
Date: Fri, 21 Feb 2003 07:01:11 -0500
User-Agent: KMail/1.4.3
References: <233C89823A37714D95B1A891DE3BCE5202AB1F37@xch-a.win.zambeel.com>
In-Reply-To: <233C89823A37714D95B1A891DE3BCE5202AB1F37@xch-a.win.zambeel.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200302210701.11485.song.zhao@nuix.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> manish>> I had noticed a degradation in performance with hyperthreadin
> turned on. Search on google and u will find many others did too. Dont
> remember the exact reason

Ok, I will try that

> On that note, I have also done benchmarking with a Supermicro E7500 board
> (P4DPR, Intel Gigabit 82544GC onboard controller), the tests I ran included
> Netperf, Netperf3, NetPIPE (TCP), Tbench, nttcp, Aim9 and the ones I
> mentioned above. It seemed that if I had two identical machines hooked up
> directly (back to back with CAT5E crossover cable), the performance would
> be
>
> a lot better and is very consistent. I tried different combinations
> HT=on/off, CPU affinity, IRQ affinity, SMP/UP. Some results were:
>
> manish>> Can you connect the systems via a gigabit switch?

Yes, I can connect the system via a gigabit switch, however I didn't run my 
testings with the boxes connected through the switch. 

>
> Supermicro
> =========
> Netperf Result (MB/s) - 112.21
> Netperf3 Result (MB/s) - 112.22
> Tbench Result (MB/s) - 114.48
> Nttcp Result (Mb/s) - 946.55
>
> manish>> which board is this? I mean what NICs and what NICs is the data
> being sent to? Which driver are you using?

Two identical boxes connected back to back (Supermicro P4DPR motherboard, 
E7500 chipset, dual 1.8GHz, Intel Gigabit 82544GC onboard controller, please 
note that the PCI interface of the Gigabit controller only supports 
32bit/33MHz, 32bit/66MHz but that doesn't seem to mattter much). The data is 
being sent to and from the Gigabit controller. 

The software driver I am using is e1000, driver version 4.4.12-k1, 2.4.20 
kernel. 

>
> However, if I hook it up to a different machine, problems started to occur.
> For example, with the Tyan S2720 Thunder i7500  board (E7500 chipset, Intel
> 82544EI onboard gigabit controller), I see good performance on the Tyan but
> not Supermicro.
>
> Supermicro
> =========
> Netperf Result (MB/s) - 29.23
> Netperf3 Result (MB/s) - 78.19
> Tbench Result (MB/s) - 117.32
> Nttcp Result (Mb/s) - 646.77
>
> manish>> which board is this? I mean what NICs and what NICs is the data
> being sent to? Which driver are you using?
>
> Tyan
> ====
> Netperf Result (MB/s) - 112.22
> Netperf3 Result (MB/s) - 112.02
> Tbench Result (MB/s) - can't find it
> Nttcp Result (Mb/s) - 945.9
>
> manish>> which board is this? I mean what NICs and what NICs is the data
> being sent to? Which driver are you using?

Server being the Supermicro P4DPR, client being the Tyan S2720 Thunder i7500. 
(The other way around doesn't seem to matter) On the Tyan, its got the Intel 
PRO/1000 XT Gigabit Server 82544EI onboard controller which supports PCI-X, 
64bit/133MHz 

The software driver is the same as above: e1000, version 4.4.12-k1

