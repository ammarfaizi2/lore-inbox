Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319269AbSHNTe1>; Wed, 14 Aug 2002 15:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319274AbSHNTe1>; Wed, 14 Aug 2002 15:34:27 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:48139 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S319269AbSHNTe0>;
	Wed, 14 Aug 2002 15:34:26 -0400
Message-ID: <3D5AB120.BB7700AB@zip.com.au>
Date: Wed, 14 Aug 2002 12:36:00 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Steven Cole <elenstev@mesatop.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Performance differences for recent kernels running forky test.
References: <1029352630.14756.140.camel@spc9.esa.lanl.gov>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Cole wrote:
> 
> I ran the following lots_of_forks.sh script for several kernels.
> 
> http://people.nl.linux.org/~phillips/patches/lots_of_forks.sh
> 
> ...
>         2.4.20-pre2     2.4.20-pre2-ac1 2.5.28          2.5.31
> 
> 1       24.96           53.18           39.91           37.04
> 2       24.92           52.42           44.91           45.88
> 3       24.69           50.69           48.63           44.89
> 4       24.39           51.9            58.12           55.8
> 5       24.72           46.14           49.81           43.18
> 6       24.34           47.99           57.62           40.93
> 7       24.64           52.33           50.42           47.27
> 8       24.53           52.84           45              36.49
> 

That's the page_add_rmap/page_remove_rmap thing.  Could you retest
2.5.31 with
http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.31/stuff-sent-to-linus/everything.gz
applied?
