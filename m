Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272130AbRH2WsJ>; Wed, 29 Aug 2001 18:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272129AbRH2WsA>; Wed, 29 Aug 2001 18:48:00 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:57362 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S272128AbRH2Wrz>; Wed, 29 Aug 2001 18:47:55 -0400
Message-ID: <3B8D712C.1441BC5A@zip.com.au>
Date: Wed, 29 Aug 2001 15:48:12 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Rees <dbr@greenhydrant.com>
CC: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        ext3-users@redhat.com
Subject: Re: kupdated, bdflush and kjournald stuck in D state on RAID1 device 
 (deadlock?)
In-Reply-To: <20010829131720.A20537@greenhydrant.com> <3B8D54F3.46DC2ABB@zip.com.au>, <3B8D54F3.46DC2ABB@zip.com.au>; <20010829141451.A20968@greenhydrant.com> <3B8D60CF.A1400171@zip.com.au>, <3B8D60CF.A1400171@zip.com.au>; <20010829144016.C20968@greenhydrant.com> <3B8D6BF9.BFFC4505@zip.com.au>,
		<3B8D6BF9.BFFC4505@zip.com.au>; from akpm@zip.com.au on Wed, Aug 29, 2001 at 03:26:01PM -0700 <20010829153818.B21590@greenhydrant.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Rees wrote:
> 
> ...
> 
> The machine was and is still working mostly ok.  Since I typed "umount /opt",
> the opt directory doesn't show any contents any more, but before that things
> appear OK.  I can still use fdisk to look at the partition layout of the
> drives in /opt raid1 array.  /proc/mdstat is normal.
> 
> There are no other software raid devices on the machine (/ is also ext3 on a
> separate drive/controller).  There are no suspicious messages printed from
> dmesg, either.
> 

Are you able to access all the underlying devices on the array?
For example, if /dev/md0 consists of /dev/hda1 and /dev/hdb2,
can you run 'cp /dev/hda1 /dev/null' and 'cp /dev/hdb1 /dev/null'?

If so, then I'm all out of ideas.  Your raid1 buffers have disappeared
into thin air :(

-
