Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314546AbSHRMPG>; Sun, 18 Aug 2002 08:15:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314548AbSHRMPF>; Sun, 18 Aug 2002 08:15:05 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:31988 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S314546AbSHRMPF>; Sun, 18 Aug 2002 08:15:05 -0400
Subject: Re: Alloc and lock down large amounts of memory
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Gilad Ben-Yossef <gilad@benyossef.com>
Cc: Bhavana Nagendra <Bhavana.Nagendra@3dlabs.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1029672587.12504.88.camel@sake>
References: <23B25974812ED411B48200D0B774071701248520@exchusa03.intense3d.com> 
	<1029672587.12504.88.camel@sake>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 18 Aug 2002 13:18:17 +0100
Message-Id: <1029673097.15859.19.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-08-18 at 13:09, Gilad Ben-Yossef wrote:
> >     Can 256M be allocated using vmalloc, if so is it swappable?
> 
> It can be alloacted via vmalloc and AFAIK it is not swappable by
> default. This doesn't sound like a very good idea though.

There isnt enough address space for vmalloc to grab 256Mb. If you want
that much then you need to handle the fact its in page arrays not
virtually linear yourself.

> Yes. See /proc/kcore for a very obvious example. Also "Linux device
> drivers second edition" has many good exmaple on the subject in the
> chapter devoted to mmap.

A better worked example for large volumes of memory might be
drivers/media/video/bttv*.c. 

