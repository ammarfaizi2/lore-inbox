Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132006AbRAHVK4>; Mon, 8 Jan 2001 16:10:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132029AbRAHVKq>; Mon, 8 Jan 2001 16:10:46 -0500
Received: from mail.telcel.net.ve ([200.35.64.9]:32400 "EHLO
	mail01.t-net.net.ve") by vger.kernel.org with ESMTP
	id <S132006AbRAHVKo> convert rfc822-to-8bit; Mon, 8 Jan 2001 16:10:44 -0500
Date: Mon, 8 Jan 2001 17:10:30 -0400 (VET)
From: Ernesto Hernandez-Novich <emhn@telcel.net.ve>
To: linux-kernel@vger.kernel.org
Subject: Re: Shared memory not enabled in 2.4.0?
In-Reply-To: <882569CE.0069993A.00@hqoutbound.ops.3com.com>
Message-ID: <Pine.LNX.4.21.0101081708310.758-100000@freakazoid.nuevomundo.seg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jan 2001 Steven_Snyder@3com.com wrote:
> For some reason shared memory is not being enabled on my system running kernel
> v2.4.0 (on RedHat v6.2,  with all updates applied).
> 
> Per the documentation I have this line in my /etc/fstab:
> 
>      none  /dev/shm  shm defaults  0 0
> 
> Yes, I have created this subdirectory:
> 
>      # ls -l /dev | grep shm
>      drwxrwxrwt    1 root     root            0 Jan  7 11:54 shm
> 
> No complaints are seen at startup, yet I still have no shared memory:
> 
>      # cat /proc/meminfo
>              total:    used:    free:  shared: buffers:  cached:
>      Mem:  130293760 123133952  7159808        0 30371840 15179776
>      Swap: 136241152        0 136241152
>      MemTotal:       127240 kB
>      MemFree:          6992 kB
>      MemShared:           0 kB
>      Buffers:         29660 kB
>      Cached:          14824 kB
>      Active:           3400 kB
>      Inact_dirty:     37872 kB
>      Inact_clean:      3212 kB
>      Inact_target:        4 kB
>      HighTotal:           0 kB
>      HighFree:            0 kB
>      LowTotal:       127240 kB
>      LowFree:          6992 kB
>      SwapTotal:      133048 kB
>      SwapFree:       133048 kB

You should check shared memory with "ipcs" instead.

Make sure you enabled "System V IPC" under "General Setup" (it's a
default value, though).
-- 
Ernesto Hernández-Novich - Running Linux 2.4.0 i686 - Unix: Live free or die!
-----BEGIN GEEK CODE BLOCK-----
Version: 3.1
GCS/E d+(++) s+: a C+++$ UBLAVHIOSC*++++$ P++++$ L+++$ E- W+ N++ o K++ w--- O-
M- V PS+ PE Y+ PGP>++ t+ 5 X+ R* tv+ b++ DI+++$ D++ G++ e++ h r++ y+
-----END GEEK CODE BLOCK-----


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
