Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317894AbSGKUJS>; Thu, 11 Jul 2002 16:09:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317896AbSGKUJQ>; Thu, 11 Jul 2002 16:09:16 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:522 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317894AbSGKUID>;
	Thu, 11 Jul 2002 16:08:03 -0400
Message-ID: <3D2DE5D7.B65C7D08@zip.com.au>
Date: Thu, 11 Jul 2002 13:08:55 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Peter Osterlund <petero2@telia.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.25: buffer layer error at buffer.c:406
References: <m2ofderr34.fsf@best.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Osterlund wrote:
> 
> When I booted 2.5.25 I got the error "buffer layer error at
> buffer.c:406". It happened three times within one second. After that it
> didn't happen again. The error messages didn't seem to cause any harm.
> 
> I rebooted the machine, but the error didn't show up again. The only
> difference was that on the first boot, the machine decided to run an
> ext2 file system check.
> 

Looks like the fsck left some pagecache behind, perhaps with a
different blocksize.  I have some adjustments in that ares which
_may_ make it go away - not sure.

Is it the root filesystem?  And could you please send me the
`dumpe2fs -h' output for that filesystem?

Thanks.

-
