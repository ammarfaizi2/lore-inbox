Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265567AbSKTC1s>; Tue, 19 Nov 2002 21:27:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265570AbSKTC1s>; Tue, 19 Nov 2002 21:27:48 -0500
Received: from aslan.scsiguy.com ([63.229.232.106]:32268 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S265567AbSKTC1r>; Tue, 19 Nov 2002 21:27:47 -0500
Date: Tue, 19 Nov 2002 19:32:49 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Raptorfan <raptorfan@earthlink.net>, linux-kernel@vger.kernel.org
Subject: Re: aic7xxx driver failing (2.4.19-ac4)
Message-ID: <763600000.1037759569@aslan.scsiguy.com>
In-Reply-To: <000e01c29036$8bdc2790$420aa8c0@beast>
References: <001b01c28ff8$61ad1670$420aa8c0@beast>
 <1604970000.1037732321@aslan.btc.adaptec.com>
 <000e01c29036$8bdc2790$420aa8c0@beast>
X-Mailer: Mulberry/3.0.0a5 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> A slight improvement: the kernel no longer oopses but still never
> completely makes it thru boot.

Are you running with memory mapped I/O enabled?  Since you have a VIA
chipset, using memory mapped I/O can be problematic.  If using PIO
works for you, I'd like to work with you toward making the memory mapped
I/O test in the driver automatically detect configurations such as yours
that do not function correctly when mem I/O is used.  You should be able
to disable mmap I/O in 6.2.21 via kernel config or by setting an aic7xxx
option on the command line (nomemio I think, but I don't have the sources
in front of me right now).

--
Justin
