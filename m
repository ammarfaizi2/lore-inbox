Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313045AbSDOH1s>; Mon, 15 Apr 2002 03:27:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313057AbSDOH1s>; Mon, 15 Apr 2002 03:27:48 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:33037 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S313045AbSDOH1r>;
	Mon, 15 Apr 2002 03:27:47 -0400
Message-ID: <3CBA80C7.467FA654@zip.com.au>
Date: Mon, 15 Apr 2002 00:27:03 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: J Sloan <joe@tmsusa.com>
CC: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.8 final - another data point
In-Reply-To: <3CB9EF57.6010609@tmsusa.com> <3CBA6943.4000701@tmsusa.com> <3CBA74A6.3080407@tmsusa.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J Sloan wrote:
> 
> FWIW -
> 
> One other observation was the numerous
> syslog entries generated during the test,
> which were as follows:
> 
> Apr 14 20:40:35 neo kernel: invalidate: busy buffer
> Apr 14 20:41:15 neo last message repeated 72 times
> Apr 14 20:44:41 neo last message repeated 36 times
> Apr 14 20:45:24 neo last message repeated 47 times
> 

If that is happening during the dbench run, then something
is wrong.

What filesystem and I/O drivers are you using?  LVM?
RAID?

Please replace that line in fs:buffer.c:invalidate_bdev()
with a BUG(), or show_stack(0), send the ksymoops output.

Thanks.

-
