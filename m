Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317468AbSFRQKc>; Tue, 18 Jun 2002 12:10:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317471AbSFRQKb>; Tue, 18 Jun 2002 12:10:31 -0400
Received: from rrcs-sw-24-153-135-82.biz.rr.com ([24.153.135.82]:29124 "HELO
	UberGeek") by vger.kernel.org with SMTP id <S317468AbSFRQKa> convert rfc822-to-8bit;
	Tue, 18 Jun 2002 12:10:30 -0400
Subject: Re: Shrinking ext3 directories
From: Austin Gonyou <austin@digitalroadkill.net>
To: DervishD <raul@pleyades.net>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3D0F5AFC.mailGSE111D9L@viadomus.com>
References: <3D0F5AFC.mailGSE111D9L@viadomus.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Organization: 
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 18 Jun 2002 11:10:26 -0500
Message-Id: <1024416626.7681.39.camel@UberGeek>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use a volume manager?(LVM or EVMS maybe.) You can grow and shrink their
volumes dynamically. EXT3 mus support ioctls for this, but if it does,
cause I've seen it doesn with EXT2, then you're good.

On Tue, 2002-06-18 at 11:08, DervishD wrote:
>     Hi all :))
> 
>     All of you know that if you create a lot of files or directories
> within a directory on ext2/3 and after that you remove them, the
> blocks aren't freed (this is the reason behind the lost+found block
> preallocation). If you want to 'shrink' the directory now that it
> doesn't contain a lot of leafs, the only solution I know is creating
> a new directory, move the remaining leafs to it, remove the
> 'big-unshrinken' directory and after that renaming the new directory:
> 
>     $ mkdir new-dir
>     $ mv bigone/* new-dir/
>     $ rmdir bigone
>     $ mv new-dir bigone
>     (Well, sort of)
> 
>     Any other way of doing the same without the mess?
> 
>     Thanks a lot :)
>     Raúl
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Austin Gonyou <austin@digitalroadkill.net>
