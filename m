Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129197AbRB0HHm>; Tue, 27 Feb 2001 02:07:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129245AbRB0HHc>; Tue, 27 Feb 2001 02:07:32 -0500
Received: from mail.valinux.com ([198.186.202.175]:63494 "EHLO
	mail.valinux.com") by vger.kernel.org with ESMTP id <S129197AbRB0HHU>;
	Tue, 27 Feb 2001 02:07:20 -0500
Date: Mon, 26 Feb 2001 23:06:47 -0800
From: "H . J . Lu" <hjl@valinux.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: NFS maillist <nfs@lists.sourceforge.net>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [NFS] Updated patch for the [2.4.x] NFS 'missing directory entry a.k.a. IRIX server' problem...
Message-ID: <20010226230647.A14094@valinux.com>
In-Reply-To: <14997.9938.106305.635202@charged.uio.no> <20010226152826.A20653@valinux.com> <15003.20448.999929.948597@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15003.20448.999929.948597@charged.uio.no>; from trond.myklebust@fys.uio.no on Tue, Feb 27, 2001 at 07:57:36AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 27, 2001 at 07:57:36AM +0100, Trond Myklebust wrote:
> >>>>> " " == H J Lu <hjl@valinux.com> writes:
> 
>      > I don't know how it will work with real 64bit cookies on a
>      > 32bit host for NFS V3 since you truncate it into 32bit during
>      > sign extension.
> 
> It won't for the moment, but that's a problem with the readdir() API
> which uses the 32-bit off_t rather than loff_t for the filldir()

I noticed that also.

> interface. The reason I added an extra truncation for the value of
> file->f_pos (which is used to fill the d_off field only for the last
> dirent) was for consistency with this interface.
> 
> I do have a patch to change the format of filldir too, but it'll
> probably have to wait until Linux 2.5.
> 

I much prefer to have a new getdents system call which will also return
d_type so that the 32 bit function in glibc can use this new getdents
instead of getdents64.


-- 
H.J. Lu (hjl@valinux.com)
