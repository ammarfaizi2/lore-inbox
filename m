Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292397AbSBUOnk>; Thu, 21 Feb 2002 09:43:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292396AbSBUOnW>; Thu, 21 Feb 2002 09:43:22 -0500
Received: from xsmtp.ethz.ch ([129.132.97.6]:45788 "EHLO xfe3.d.ethz.ch")
	by vger.kernel.org with ESMTP id <S292397AbSBUOnB>;
	Thu, 21 Feb 2002 09:43:01 -0500
Message-ID: <3C7506B5.20103@dplanet.ch>
Date: Thu, 21 Feb 2002 15:39:49 +0100
From: Giacomo Catenazzi <cate@dplanet.ch>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.4) Gecko/20011128 Netscape6/6.2.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: Giacomo Catenazzi <cate@debian.org>, andersen@codepoet.org,
        Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
Subject: Re: linux kernel config converter
In-Reply-To: <fa.fsgrt4v.1bngh9t@ifi.uio.no> <fa.hp69onv.i7qtq3@ifi.uio.no> <3C74FF03.8070502@debian.org> <3C7503B1.E7CA83AA@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Feb 2002 14:42:59.0551 (UTC) FILETIME=[0EBBAEF0:01C1BAE6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jeff Garzik wrote:

>> 
> For directories like kernel/* and mm/* and arch/*, I imagine that down
> the road we will want kernel.conf and mm.conf too, though right now they
> would probably remain as makefiles...
> 
> If you look closely at the problem, you will see there is no fundamental
> reason why we cannot package makefile rules like we want to package
> config information.


I agree that in most case (drivers) it is the right thing.
But for kernel/, arch/ there are no simple way to tell:
"this makefile rule belong to this configuration".
In such cases we should not split makefiles and configurations
in an artificial way.
We should not generalize and split configuration and makefile
just because in most case it is the right thing.

[ Some Makefile define at the beginning some flags that
   should be used for all driver in such subdir.
   These info should be in a 'main' .conf (main = where normal
   user would check, without grep to all .conf)
  ]

	giacomo

