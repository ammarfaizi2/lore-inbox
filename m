Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278574AbRJ1QgG>; Sun, 28 Oct 2001 11:36:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278572AbRJ1Qf4>; Sun, 28 Oct 2001 11:35:56 -0500
Received: from postfix1-2.free.fr ([213.228.0.130]:42425 "HELO
	postfix1-2.free.fr") by vger.kernel.org with SMTP
	id <S278574AbRJ1Qfp>; Sun, 28 Oct 2001 11:35:45 -0500
Date: Sun, 28 Oct 2001 13:40:16 +0100
From: Thierry Laronde <tlaronde@polynum.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Virtual(?) kernel root
Message-ID: <20011028134016.B239@polynum.org>
In-Reply-To: <20011026215939.A13222@polynum.org> <200110280825.f9S8PROO004923@leija.fmi.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200110280825.f9S8PROO004923@leija.fmi.fi>; from hurtta@leija.mh.fmi.fi on Sun, Oct 28, 2001 at 10:25:27AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 28, 2001 at 10:25:27AM +0200, Kari Hurtta wrote:
> > 
> > Has an equivalent scheme being already discussed?
> 
> On linux/fs/namespace.c there is following comment: (from linux 2.4.12)
> 
> /*
>  * Absolutely minimal fake fs - only empty root directory and nothing else.
>  * In 2.5 we'll use ramfs or tmpfs, but for now it's all we need - just
>  * something to go with root vfsmount.
>  */
> <...>
> static DECLARE_FSTYPE(root_fs_type, "rootfs", rootfs_read_super, FS_NOMOUNT);
>  
> 
> But I do not think that that comment refers to equivalent scheme
> than what you are proposing.

Thanks for the tip. For the major part (don't speaking about /kbin or
something like that), I think the change would be more a way to see the
stuff than a lot of coding changes. In this case, having always and a
sole kernel root, will allow to mount all sort of fs (virtual or not),
and to allow kernel threads to refere to this unchanged root.

Cheers,
-- 
Thierry Laronde (Alceste) <tlaronde@polynum.org>
Key fingerprint = 0FF7 E906 FBAF FE95 FD89  250D 52B1 AE95 6006 F40C
