Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317495AbSFRQ72>; Tue, 18 Jun 2002 12:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317496AbSFRQ71>; Tue, 18 Jun 2002 12:59:27 -0400
Received: from warden3-p.diginsite.com ([208.147.64.186]:26592 "HELO
	warden3.diginsite.com") by vger.kernel.org with SMTP
	id <S317495AbSFRQ7T>; Tue, 18 Jun 2002 12:59:19 -0400
Date: Tue, 18 Jun 2002 09:54:42 -0700 (PDT)
From: David Lang <dlang@diginsite.com>
To: Padraig Brady <padraig@antefacto.com>
cc: DervishD <raul@pleyades.net>, Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Shrinking ext3 directories
In-Reply-To: <3D0F5DFE.5060301@antefacto.com>
Message-ID: <Pine.LNX.4.44.0206180952000.16916-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

this won't be part of the htree indexing, however the biggest reason to be
concerned about shrinking the directory is the horrible performance that
ext2/3 have when dealing with large directories and the htree stuff will
hopefully eliminate that performance problem so the only remaining reason
would be to free up a few K of disk space (which is a MUCH less critical
issue)

David Lang


 On Tue, 18 Jun 2002, Padraig Brady
wrote:

> Date: Tue, 18 Jun 2002 17:21:18 +0100
> From: Padraig Brady <padraig@antefacto.com>
> To: DervishD <raul@pleyades.net>
> Cc: Linux-kernel <linux-kernel@vger.kernel.org>
> Subject: Re: Shrinking ext3 directories
>
> DervishD wrote:
> >     Hi all :))
> >
> >     All of you know that if you create a lot of files or directories
> > within a directory on ext2/3 and after that you remove them, the
> > blocks aren't freed (this is the reason behind the lost+found block
> > preallocation). If you want to 'shrink' the directory now that it
> > doesn't contain a lot of leafs, the only solution I know is creating
> > a new directory, move the remaining leafs to it, remove the
> > 'big-unshrinken' directory and after that renaming the new directory:
> >
> >     $ mkdir new-dir
> >     $ mv bigone/* new-dir/
> >     $ rmdir bigone
> >     $ mv new-dir bigone
> >     (Well, sort of)
>
> The zipdir component of fslint does this (while maintaining permissions
> etc.).
>
> >     Any other way of doing the same without the mess?
>
> Not at present I think. Perhaps we'll get it for free with
> the new htree directory indexing?
>
> Padraig.
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
