Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267973AbRGZOZt>; Thu, 26 Jul 2001 10:25:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267988AbRGZOZj>; Thu, 26 Jul 2001 10:25:39 -0400
Received: from uf.kadan.cz ([194.212.221.136]:15118 "EHLO uf.kadan.cz")
	by vger.kernel.org with ESMTP id <S267973AbRGZOZ1>;
	Thu, 26 Jul 2001 10:25:27 -0400
Date: Thu, 26 Jul 2001 16:25:11 +0200 (CEST)
From: =?windows-1250?Q?Lubom=EDr_Bulej?= <pallas@kadan.cz>
To: Deepika Kakrania <deepika@sasken.com>
cc: <linux-net@vger.rutgers.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: CBQ is not limiting bandwidth!!!
In-Reply-To: <Pine.GSO.4.30.0107261754530.26764-100000@sunk2.sasi.com>
Message-ID: <Pine.LNX.4.33.0107261623540.2339-100000@ps.kadan.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi,

>   I am defining only one class at m/c router on interface eth1. The tc
> rules set up for doing so are following.
> 
>  tc qdisc add dev eth1 root handle 1: cbq bandwidth 10Mbit cell 8 avpkt
> 1000 mpu 64
> 
>  tc class add dev eth1 parent 1:0 classud 1:1 cbq bandwidth 10Mbit rate
> 1kbit allot 1514 cell 8 weigth 100bit prio 5 maxburst 20 avpkt 1000

Add "bounded" at the end of the command... Otherwise the class borrows 
bandwidth from its parent.


Regards,
Lubomir

