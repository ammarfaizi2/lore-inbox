Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262994AbVCXDGn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262994AbVCXDGn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 22:06:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262996AbVCXDGm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 22:06:42 -0500
Received: from [218.1.67.73] ([218.1.67.73]:3491 "EHLO trust-mart.com")
	by vger.kernel.org with ESMTP id S262994AbVCXDGN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 22:06:13 -0500
Message-ID: <003001c5301e$63628400$d87f11ac@hv>
From: "hv" <hv@trust-mart.com>
To: "Mike Turcotte" <Mike.Turcotte@cityofnorthbay.ca>
Cc: <linux-kernel@vger.kernel.org>
References: <C6FD667B200BDF4F964C1BA77B796CE20F5E43@cnbmail2.city.north-bay.on.ca>
Subject: Re: memory size
Date: Thu, 24 Mar 2005 11:05:51 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.3790.1289
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.1289
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is another dell2650 with 2G memory using option  "CONFIG_HIGHMEM4G":
Memory: 2075744k/2097024k available (1858k kernel code, 20408k reserved, 
704k data, 160k init, 1179520k highmem)
2097024-1858-20408-704-160=2073894.It looks be close to 2075744. So I 
consider it would be fine.

But when I use option "CONFIG_HIGHMEM64G" in these dell6650
Memory: 16116752k/16777216k available (1855k kernel code, 135136k reserved, 
702k data, 164k init, 15335296k highmem)
16777216-1855-135136-702-164=16639359.
16639359 is far from 16116752.I think "The first 800 and sum odd MB of 
memory" would be in the area (1855k kernel code, 135136k reserved, 702k 
data, 164k init, 15335296k highmem).Is this right?


----- Original Message ----- 
From: "Mike Turcotte" <Mike.Turcotte@cityofnorthbay.ca>
To: "hv" <hv@trust-mart.com>
Cc: <linux-kernel@vger.kernel.org>
Sent: Thursday, March 24, 2005 12:57 AM
Subject: RE: memory size


The first 800 and sum odd MB of memory are not considered high memory,
so it will not appear in the output. By taking a quick look at your
numbers, it seems fine

Michael Turcotte
Information Systems
City of North Bay
200 McIntyre St. E
PO Box 360
North Bay, Ontario
P1B 8H8

Mike.Turcotte@cityofnorthbay.ca
http://www.cityofnorthbay.ca

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
> owner@vger.kernel.org] On Behalf Of hv
> Sent: Wednesday, March 23, 2005 3:09 AM
> To: hv
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: memory size
>
> The other dell6650 with 16G ram under kernel 2.6.11-rc4-mm1 is more
> oddness.
> Memory: 16116752k/16777216k available (1855k kernel code, 135136k
> reserved,
> 702k data, 164k init, 15335296k highmem)
>
>
> ----- Original Message -----
> From: "hv" <hv@trust-mart.com>
> To: <linux-kernel@vger.kernel.org>
> Sent: Wednesday, March 23, 2005 3:54 PM
> Subject: memory size
>
>
> > Hi,all:
> > This is my memory status from "dmesg":
> > Memory: 4673020k/5242880k available (1334k kernel code, 44532k
reserved,
> > 672k data, 156k init, 3800960k highmem)
> >
> >
> > But I found that available memory size is much less than physical
memory
> > size.My server is Dell6650 with P4 Xeon*4 and 5G Ram.
> > My kernel version is 2.6.12-rc1-mm1.Could any one tell my the
> > reason?Thanks.
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe
linux-kernel"
> in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
> >
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe
linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


