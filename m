Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316223AbSHOA5H>; Wed, 14 Aug 2002 20:57:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316235AbSHOA5H>; Wed, 14 Aug 2002 20:57:07 -0400
Received: from central.caverock.net.nz ([210.55.207.1]:23827 "EHLO
	central.caverock.net.nz") by vger.kernel.org with ESMTP
	id <S316223AbSHOA5G>; Wed, 14 Aug 2002 20:57:06 -0400
Date: Thu, 15 Aug 2002 11:45:40 +1200 (NZST)
From: Eric Gillespie <viking@flying-brick.caverock.net.nz>
To: Edward Coffey <ecoffey@alphalink.com.au>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: devfs_find_and_unregister fix (was Re: Linux 2.5.31)
In-Reply-To: <20020814093927.GA361@spunk>
Message-ID: <Pine.LNX.4.21.0208151142390.1877-100000@brick.flying-brick.caverock.net.nz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Aug 2002, Edward Coffey wrote:

:On Wed, Aug 14, 2002 at 08:09:05PM +1200, Eric Gillespie wrote:
:> 
:> In reply to:
:> ecoffey at alphalink dot com dot au
:> >devfs problem, make modules_install fails with
:> > if [ -r System.map ]; then /sbin/depmod -ae -F System.map 2.5.31; fi
:> >depmod: *** Unresolved symbols in
:> >/lib/modules/2.5.31/kernel/sound/core/snd.o
:> >depmod: devfs_find_and_unregister
:> 
:> fs/devfs/base.c,  Line 2315, add this:
:> 
:> --- fs/devfs/base_orig.c	Wed Aug 14 20:02:09 2002
:> +++ fs/devfs/base.c	Tue Aug 13 18:51:23 2002
:> @@ -2312,6 +2312,7 @@
:>  EXPORT_SYMBOL(devfs_mk_symlink);
:>  EXPORT_SYMBOL(devfs_mk_dir);
:>  EXPORT_SYMBOL(devfs_get_handle);
:> +EXPORT_SYMBOL(devfs_find_and_unregister);
:>  EXPORT_SYMBOL(devfs_get_flags);
:>  EXPORT_SYMBOL(devfs_set_flags);
:>  EXPORT_SYMBOL(devfs_get_maj_min);
:
:Thanks :?) 
:

Whoops - it's a patch file - sorry.  You know how to patch?
Basically, the line number is mentioned, as well as the lines to ADD.

I notice someone else on the list put the same thing up, so this is only
duplication <grin> - my apologies if I threw you off guard.

I'll CC: this to the kernel list too, just so they know I read it too 8-)

-- 
 /|   _,.:*^*:.,   |\           Cheers from the Viking family, 
| |_/'  viking@ `\_| |            including Pippin, our cat
|    flying-brick    | $FunnyMail  Bilbo   : Now far ahead the Road has gone,
 \_.caverock.net.nz_/     5.39    in LOTR  : Let others follow it who can!

