Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315080AbSDWGIO>; Tue, 23 Apr 2002 02:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315081AbSDWGIL>; Tue, 23 Apr 2002 02:08:11 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:43532
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S315080AbSDWGIE>; Tue, 23 Apr 2002 02:08:04 -0400
Date: Mon, 22 Apr 2002 23:06:01 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Ed Sweetman <ed.sweetman@wmich.edu>
cc: "J.A. Magallon" <jamagallon@able.es>,
        Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHSET] Linux 2.4.19-pre7-jam5
In-Reply-To: <1019539515.970.3.camel@psuedomode>
Message-ID: <Pine.LNX.4.10.10204222302220.32212-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


bottom of ide-pci.c

there is a failed test to isolate multi-function chips which carry a real
host inside.

ide_scan_pcidev()

else if (d->order_fix)
	d->order_fix(dev, d);
--
--
--

delete the three lines after d->order_fix(dev, d);


Cheers and Apology,


On 23 Apr 2002, Ed Sweetman wrote:

> Seems that ide-6 disables Promise ide controllers. Jam2 worked and there
> are quite extensive changes to the pdc driver and general ide drivers so
> I was unable to eye out what is going wrong.  It doesn't even show up in
> lspci.    
> 
> 
> Can anyone else verify that this is a general Promise bug in ide-6.  If
> not i'll reboot and give an exact list of my card and see if maybe it's
> falling through the cracks.  
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group

