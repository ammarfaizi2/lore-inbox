Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319215AbSILXlG>; Thu, 12 Sep 2002 19:41:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319217AbSILXlF>; Thu, 12 Sep 2002 19:41:05 -0400
Received: from tolkor.sgi.com ([192.48.180.13]:51649 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S319215AbSILXlF>;
	Thu, 12 Sep 2002 19:41:05 -0400
Subject: Re: 2.4.20pre5aa2
From: Stephen Lord <lord@sgi.com>
To: Samuel Flory <sflory@rackable.com>
Cc: Andrea Arcangeli <andrea@suse.de>, Austin Gonyou <austin@coremetrics.com>,
       Christian Guggenberger 
	<christian.guggenberger@physik.uni-regensburg.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>, linux-xfs@oss.sgi.com
In-Reply-To: <3D81235B.6080809@rackable.com>
References: <20020911201602.A13655@pc9391.uni-regensburg.de>
	<1031768655.24629.23.camel@UberGeek.coremetrics.com>
	<20020911184111.GY17868@dualathlon.random>  <3D81235B.6080809@rackable.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 12 Sep 2002 18:45:28 -0500
Message-Id: <1031874330.1236.3.camel@snafu>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-09-12 at 18:29, Samuel Flory wrote:
>   Your patch seem to solve only some  of the xfs issues for me.  Before 
> the patch my system hung when booting.  This only occured I  had xfs 
> compiled into the kernel.   After patching  things seemed fine, but 
> durning "dbench 32" the system locked.  Upon rebooting and attempting to 
> mount the filesystem I got this:
> XFS mounting filesystem md(9,2)
> Starting XFS recovery on filesystem: md(9,2) (dev: 9/2)
> kernel BUG at page_buf.c:578!
> <and so on>
> 

Line numbers in no way line up with the code I have in front of me,
However, this appears to equate to a failure in the address space
remapping code. This is not a failure I have ever seen in our code
base.

Steve


-- 

Steve Lord                                      voice: +1-651-683-3511
Principal Engineer, Filesystem Software         email: lord@sgi.com

