Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265937AbSIRKE3>; Wed, 18 Sep 2002 06:04:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266012AbSIRKE3>; Wed, 18 Sep 2002 06:04:29 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:45562
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265937AbSIRKE2>; Wed, 18 Sep 2002 06:04:28 -0400
Subject: Re: 2.4.18: Re-read table failed with error 16: Device or resource
	busy - error
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Rainer Krienke <krienke@uni-koblenz.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200209180851.10297.krienke@uni-koblenz.de>
References: <200209180851.10297.krienke@uni-koblenz.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 18 Sep 2002 11:13:11 +0100
Message-Id: <1032343991.20402.58.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What I did was to add a partition on a disk that has other mounted (e.g. root) 
> partitions on it. I did not change the numbering or positions of any of the 
> partitions in use.The new partition was simply added after all existing 
> partitions.
>  
> So the question is why does the kernel deny to reread the partiton table and 
> force me to reboot instaed of simply doing the reread? Are there any good 
> reasons for this "bad" behaviour?

You credit the partition code with a little more intelligence than it
actually has. The problem is also a little harder than it seems when you
add partitions that might change the order of stuff. 

The LVM layer supports dynamically resizing volumes, adding new volumes
and the like. Thats probably the right way to go for such things

