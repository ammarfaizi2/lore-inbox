Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319298AbSH2Sld>; Thu, 29 Aug 2002 14:41:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319299AbSH2Slc>; Thu, 29 Aug 2002 14:41:32 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:33033 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S319298AbSH2Sl2>; Thu, 29 Aug 2002 14:41:28 -0400
Message-ID: <3D6E6B64.66203783@zip.com.au>
Date: Thu, 29 Aug 2002 11:43:48 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Badari Pulavarty <pbadari@us.ibm.com>
CC: linux-kernel@vger.kernel.org, Gerrit Huizenga <gerrit@us.ibm.com>,
       Hans-J Tannenberger <hjt@us.ibm.com>,
       Janet Morgan <janetmor@us.ibm.com>, Mike Anderson <andmike@us.ibm.com>,
       Martin Bligh <mjbligh@us.ibm.com>
Subject: Re: 2.5.32 IO performance issues
References: <200208291820.g7TIKHA19433@eng2.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty wrote:
> 
> Hi,
> 
> I am having severe IO performance problems with 2.5.32 (2.5.31 works fine).
> I was wondering what caused this.
> 
> As you can see, IO rate went from
> 
>                 384MB/sec with 6% CPU utilization on 2.5.31
>                         to
>                 120MB/sec with 19% CPU utilization on 2.5.32
> 
> ...
> 151712 default_idle                             2370.5000
> 21622 __scsi_end_request                       122.8523

block-highmem is bust for scsi. (aic7xxx at least).  Does
http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.32/2.5.32-mm2/broken-out/scsi_hack.patch
fix it?
