Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316500AbSIDXyx>; Wed, 4 Sep 2002 19:54:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316582AbSIDXyx>; Wed, 4 Sep 2002 19:54:53 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:15123 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S316500AbSIDXxl>; Wed, 4 Sep 2002 19:53:41 -0400
Message-ID: <3D769D99.CF054558@zip.com.au>
Date: Wed, 04 Sep 2002 16:56:09 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20pre5aa1
References: <20020904233528.GA1238@dualathlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> ...
> 
> The 2.5 libaio that works with this kernel and 2.5 is here:
> 
>         http://www.us.kernel.org/pub/linux/kernel/people/andrea/libaio/libaio-0.3.15-2.5.tar.gz

Thanks for doing this.  The lack of AIO-aware applications and of
testing tools for AIO is a bit of a worry at present.
 
> Only in 2.4.20pre5aa1: 00_prepare-write-fixes-3-1
> 
>         Also check the i_size is in sync with the last block we allocated in
>         the metadata, it won't be updated in the commit_write if prepare_write
>         is failing.

That's the right thing to do I guess.  Is this a problem in practice?
If prepare_write() fails, generic_file_write() will truncate back to
the current i_size?
 
> Only in 2.4.20pre5aa1: 9920_kgdb-1.gz
> 
>         kgdb from akpm.

Life in the fast lane ;)  Kudos to Amit Kale.
