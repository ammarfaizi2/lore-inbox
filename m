Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315783AbSHIUrV>; Fri, 9 Aug 2002 16:47:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315784AbSHIUrU>; Fri, 9 Aug 2002 16:47:20 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:55304 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315783AbSHIUrU>;
	Fri, 9 Aug 2002 16:47:20 -0400
Message-ID: <3D542AAE.64B70B55@zip.com.au>
Date: Fri, 09 Aug 2002 13:48:47 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Phil Auld <pauld@egenera.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: why is lseek broken (>= 2.4.11) ?
References: <20020809084915.P3542@vienna.EGENERA.COM>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phil Auld wrote:
> 
> Hi folks,
> 
> There was a brief thread a couple of months ago about the change in
> lseek for block devices. The thread is here:
> 
> http://marc.theaimsgroup.com/?t=102406030100003&r=1&w=2
> 
> The change, which looks to have come in with 2.4.11, returns
> EINVAL from an lseek on a block device attempting to set pos past
> the size of the device.
> 
> This causes current versions glibc to exhibit non-SUS3 lseek behavior.
> 
> Are there plans to revert this? It seems that this is something that
> should be addressed in glibc first and then have the kernel change.
> 
> There is no resolution in the thread above, nor is there any
> justification for the change. It just peters out.

What should the behaviour be?   The lseek should succeed,
but subsequent reads and writes return zero?
