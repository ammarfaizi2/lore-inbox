Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129281AbRBLJfj>; Mon, 12 Feb 2001 04:35:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129524AbRBLJf3>; Mon, 12 Feb 2001 04:35:29 -0500
Received: from ns.suse.de ([213.95.15.193]:40966 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129281AbRBLJfQ>;
	Mon, 12 Feb 2001 04:35:16 -0500
Date: Mon, 12 Feb 2001 10:35:10 +0100
From: Olaf Hering <olh@suse.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: "H. Peter Anvin" <hpa@transmeta.com>, autofs@linux.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: race in autofs / nfs
Message-ID: <20010212103510.A16844@suse.de>
In-Reply-To: <20010211211701.A7592@suse.de> <3A86F6AA.1416F479@transmeta.com> <shsbss8i8iq.fsf@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <shsbss8i8iq.fsf@charged.uio.no>; from trond.myklebust@fys.uio.no on Mon, Feb 12, 2001 at 09:57:01AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, Trond Myklebust wrote:

> >>>>> " " == H Peter Anvin <hpa@transmeta.com> writes:
> 
>      > Olaf Hering wrote:
>     >>
>     >> Hi,
>     >>
>     >> there is a race in 2.4.1 and 2.4.2-pre3 in autofs/nfs.  When
>     >> the cwd is on the nfs mounted server (== busy) and you try to
>     >> reboot the shutdown hangs in "rcautofs stop". I can reproduce
>     >> it everytime.
>     >>
> 
>      > Sounds like an NFS bug in umount.
> 
> Or a dcache bug: the above points to a corruption of the mnt_count
> which is supposed to be > 0 if the partition is in use. I'm seeing a
> similar leak for ext2 partitions (not involving autofs or NFS).

Send me patches :)
autofs is the latest, btw.
http://www.de.kernel.org/pub/linux/daemons/autofs/testing-v4/autofs-4.0.0pre9.tar.bz2


Gruss Olaf

-- 
 $ man clone

BUGS
       Main feature not yet implemented...
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
