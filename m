Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277565AbRJRC5z>; Wed, 17 Oct 2001 22:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277567AbRJRC5p>; Wed, 17 Oct 2001 22:57:45 -0400
Received: from [209.250.58.160] ([209.250.58.160]:35336 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S277565AbRJRC5f>; Wed, 17 Oct 2001 22:57:35 -0400
Date: Wed, 17 Oct 2001 21:57:51 -0500
From: Steven Walter <srwalter@yahoo.com>
To: Michael Rothwell <rothwell@holly-springs.nc.us>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.10 - errors, freeze when burning CD-R
Message-ID: <20011017215750.C5511@hapablap.dyn.dhs.org>
Mail-Followup-To: Steven Walter <srwalter@yahoo.com>,
	Michael Rothwell <rothwell@holly-springs.nc.us>,
	linux-kernel@vger.kernel.org
In-Reply-To: <1003367175.1721.7.camel@gromit>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1003367175.1721.7.camel@gromit>; from rothwell@holly-springs.nc.us on Wed, Oct 17, 2001 at 09:06:14PM -0400
X-Uptime: 5:58pm  up 1 day, 23:07,  0 users,  load average: 1.10, 1.10, 1.06
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just a question:  did you compile the kernel with gcc 3.0?  I had a
similar problem with CD-R drives and ide-scsi, where the kernel would
lock for a few seconds, spewing "x-order allocation failed" into dmesg.
Recompiling the kernel with gcc-2.95.3 fixed things.

On Wed, Oct 17, 2001 at 09:06:14PM -0400, Michael Rothwell wrote:
> I'm running 2.4.10 with the ext3 patch. I got a total freeze when
> burning a CD-R last night. The syslog has lots of "3-order allocation
> failed" messages. 
> 
> The SCSI bus keeps getting reset. I'm wondering if Nautilus is
> interfering with CD-R recording as well. I've got hundreds of "kernel:
> cdrom: This disc doesn't have any tracks I recognize!" messages. In
> fact, they are the last things in my syslog before the freeze. Nearly
> 600 of them, consensed in groups of 30 or so ("message repeated...")
> 
> Oct 16 23:22:02 gromit kernel: cdrom: This disc doesn't have any tracks
> I recognize!
> Oct 16 23:22:33 gromit last message repeated 15 times
> Oct 16 23:23:35 gromit last message repeated 31 times
> Oct 16 23:24:19 gromit last message repeated 22 times
> Oct 16 23:24:21 gromit gconfd (rothwell-1633): 19 items remain in the
> cache after cleaning already-synced items older than $Oct 16 23:24:21
> gromit kernel: cdrom: This disc doesn't have any tracks I recognize!
> Oct 16 23:24:31 gromit last message repeated 5 times
> Oct 16 23:24:33 gromit kernel: __alloc_pages: 3-order allocation failed
> (gfp=0x20/0) from c012c920
> Oct 16 23:24:33 gromit last message repeated 159 times
> Oct 16 23:24:33 gromit kernel: cdrom: This disc doesn't have any tracks
> I recognize!
> Oct 16 23:25:05 gromit last message repeated 16 times
> Oct 16 23:25:15 gromit last message repeated 5 times
> Oct 16 23:25:16 gromit kernel: __alloc_pages: 3-order allocation failed
> (gfp=0x20/0) from c012c920
> Oct 16 23:25:16 gromit last message repeated 139 times
> Oct 16 23:25:17 gromit kernel: cdrom: This disc doesn't have any tracks
> I recognize!
> Oct 16 23:25:40 gromit last message repeated 11 times
> Oct 16 23:25:40 gromit kernel: __alloc_pages: 3-order allocation failed
> (gfp=0x20/0) from c012c920
> Oct 16 23:25:40 gromit last message repeated 139 times
> Oct 16 23:25:42 gromit kernel: cdrom: This disc doesn't have any tracks
> I recognize!
> Oct 16 23:25:58 gromit last message repeated 8 times
> Oct 16 23:25:58 gromit kernel: __alloc_pages: 3-order allocation failed
> (gfp=0x20/0) from c012c920
> Oct 16 23:25:58 gromit last message repeated 139 times
> Oct 16 23:26:00 gromit kernel: cdrom: This disc doesn't have any tracks
> I recognize!
> Oct 16 23:26:28 gromit last message repeated 14 times
> Oct 16 23:26:28 gromit kernel: __alloc_pages: 3-order allocation failed
> (gfp=0x20/0) from c012c920
> Oct 16 23:26:29 gromit last message repeated 109 times
> Oct 16 23:26:30 gromit kernel: cdrom: This disc doesn't have any tracks
> I recognize!
> Oct 16 23:27:02 gromit last message repeated 16 times
> Oct 16 23:27:14 gromit last message repeated 6 times
> Oct 16 23:27:14 gromit modprobe: modprobe: Can't locate module
> char-major-97
> Oct 16 23:27:14 gromit last message repeated 3 times
> Oct 16 23:27:16 gromit kernel: cdrom: This disc doesn't have any tracks
> I recognize!
> Oct 16 23:27:48 gromit last message repeated 16 times
> Oct 16 23:28:28 gromit last message repeated 20 times
> Oct 16 23:28:29 gromit su(pam_unix)[4163]: session opened for user root
> by rothwell(uid=500)
> Oct 16 23:28:30 gromit kernel: cdrom: This disc doesn't have any tracks
> I recognize!
> Oct 16 23:29:03 gromit last message repeated 16 times
> Oct 16 23:29:07 gromit last message repeated 2 times
> Oct 16 23:29:21 gromit gconfd (rothwell-1633): 18 items remain in the
> cache after cleaning already-synced items older than $Oct 16 23:29:25
> gromit kernel: cdrom: This disc doesn't have any tracks I recognize!
> Oct 16 23:29:57 gromit last message repeated 17 times
> Oct 16 23:30:25 gromit last message repeated 14 times
> Oct 16 23:30:38 gromit kernel: scsi0:0:6:0: Attempting to queue an ABORT
> message
> Oct 16 23:30:38 gromit kernel: scsi0:0:6:0: Device is active, asserting
> ATN
> Oct 16 23:30:38 gromit kernel: Recovery code sleeping
> Oct 16 23:30:38 gromit kernel: (scsi0:A:6:0): Abort Message Sent
> Oct 16 23:30:38 gromit kernel: (scsi0:A:6:0): SCB 3 - Abort Completed.
> Oct 16 23:30:38 gromit kernel: Recovery SCB completes
> Oct 16 23:30:38 gromit kernel: Recovery code awake
> Oct 16 23:30:38 gromit kernel: aic7xxx_abort returns 8194
> Oct 16 23:30:38 gromit kernel: cdrom: This disc doesn't have any tracks
> I recognize!
> Oct 16 23:31:09 gromit last message repeated 16 times
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
-Steven
In a time of universal deceit, telling the truth is a revolutionary act.
			-- George Orwell
Freedom is slavery. Ignorance is strength. War is peace.
			-- George Orwell
Those that would give up a necessary freedom for temporary safety
deserver neither freedom nor safety.
			-- Ben Franklin
