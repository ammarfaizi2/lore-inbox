Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269810AbRHIOSc>; Thu, 9 Aug 2001 10:18:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269812AbRHIOSV>; Thu, 9 Aug 2001 10:18:21 -0400
Received: from host217-33-139-17.ietf.ignite.net ([217.33.139.17]:22664 "HELO
	bee5.dirksteinberg.de") by vger.kernel.org with SMTP
	id <S269810AbRHIOSK>; Thu, 9 Aug 2001 10:18:10 -0400
Message-ID: <3B729B96.D306185C@dirksteinberg.de>
Date: Thu, 09 Aug 2001 15:17:58 +0100
From: "Dirk W. Steinberg" <dws@dirksteinberg.de>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-mosix106 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Swapping for diskless nodes
In-Reply-To: <E15Ulnx-0006zZ-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,

what you say sound a lot like a hacker solution ("check that it uses the
right GFP_ levels"). I think it's about time that this deficit of linux
as compared to SunOS or *BSD should be removed. Network paging should be
supported as a standard feature of a stock kernel compile.

/ Dirk

Alan Cox wrote:
> > what is the best/recommended way to do remote swapping via the network
> > for diskless workstations or compute nodes in clusters in Linux 2.4?=20
> > Last time i checked was linux 2.2, and there were some races related=20
> > to network swapping back then. Has this been fixed for 2.4?
> 
> The best answer probably is "don't". Networks are high latency things for
> paging and paging is latency sensitive. If performance is not an issue then
> the nbd driver ought to work. You may need to check it uses the right
> GFP_ levels to avoid deadlocks and you might need to up the amount of atomic
> pool memory. Hopefully other hacks arent needed
> 
> [The general case of network swap is basically insoluble but its possible to
>  make it perfectly usable as Sun proved]
