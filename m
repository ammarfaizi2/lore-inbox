Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264666AbSKDMkA>; Mon, 4 Nov 2002 07:40:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265225AbSKDMkA>; Mon, 4 Nov 2002 07:40:00 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:56975 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264666AbSKDMj7>; Mon, 4 Nov 2002 07:39:59 -0500
Subject: Re: [lkcd-general] Re: What's left over.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Peter Chubb <peter@chubb.wattle.id.au>
Cc: linux@horizon.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <15813.58257.283506.424581@wombat.chubb.wattle.id.au>
References: <15813.58257.283506.424581@wombat.chubb.wattle.id.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 04 Nov 2002 13:08:03 +0000
Message-Id: <1036415283.1106.13.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-11-04 at 03:03, Peter Chubb wrote:
> >>>>> "linux" == linux  <linux@horizon.com> writes:
> 
> 
> linux> While a crash dump to just half of one of those mirrors is
> linux> fine, finding it might be a little bit tricky.  And the fact
> linux> that the kernel reassembles the mirrors automatically on boot
> linux> might make retrieving the data a little bit tricky, too.
> 
> What most other unices do is crash dump to a dedicated swap
> partition.   LKCD appears to be able to do this.  So the setup of MD
> etc., isn't going to affect anything.

I have raid1 swap. That does make a difference to the problem space.
When we get into encrypted raid5 swap over nbd (the security paranoia
dept - store all my swap crypted split into 4 disks in four
jurisdictions...) it gets really fun.

For the normal cases it doesn't seem a problem, even for raid0 swap
since before crash time you can generate a list of device/blocknumber
values and store it in the signed area

