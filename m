Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265667AbTCDX0B>; Tue, 4 Mar 2003 18:26:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265863AbTCDX0A>; Tue, 4 Mar 2003 18:26:00 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:25263 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S265667AbTCDXZ7>;
	Tue, 4 Mar 2003 18:25:59 -0500
Date: Wed, 5 Mar 2003 10:36:19 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Pavel Machek <pavel@ucw.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: sys32_ioctl -> compat_ioctl -- generic
Message-Id: <20030305103619.52ccdfe2.sfr@canb.auug.org.au>
In-Reply-To: <20030303232122.GA24018@elf.ucw.cz>
References: <20030303232122.GA24018@elf.ucw.cz>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Mar 2003 00:21:22 +0100 Pavel Machek <pavel@ucw.cz> wrote:
>
> +asmlinkage long compat_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg)

For consistancy, this should be called compat_sys_ioctl.

> +{
> +	struct file * filp;

> +	filp = fget(fd);

> +			/* find the name of the device. */
> +			if (path) {
> +				struct file *f = fget(fd); 

Is it really necessary to do another fget(fd) ?

Also, if you are adding this much code, you should add a copyright notice
to the top of the file ...

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
