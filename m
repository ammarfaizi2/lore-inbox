Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261564AbUKGOre@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261564AbUKGOre (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 09:47:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261566AbUKGOre
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 09:47:34 -0500
Received: from sv1.valinux.co.jp ([210.128.90.2]:14268 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S261564AbUKGOrb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 09:47:31 -0500
Date: Sun, 07 Nov 2004 23:43:51 +0900 (JST)
Message-Id: <20041107.234351.74751760.taka@valinux.co.jp>
To: kloczek@rudy.mif.pg.gda.pl
Cc: liudeyan@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]tar filesystem for 2.6.10-rc1-mm3(easily access tar
 file)
From: Hirokazu Takahashi <taka@valinux.co.jp>
In-Reply-To: <Pine.LNX.4.60L.0411071408320.21903@rudy.mif.pg.gda.pl>
References: <Pine.LNX.4.60L.0411071337240.21903@rudy.mif.pg.gda.pl>
	<aad1205e04110705073ee8399b@mail.gmail.com>
	<Pine.LNX.4.60L.0411071408320.21903@rudy.mif.pg.gda.pl>
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This filesystem was designed as an educational material.

However, I guess it may be used to maintain many tar archives
as they are. This is a good point that nobody should have to care
about archive/filesystem formats.

I think saving disk space is secondary effect, which wouldn't be
important.

> [..]
> >>> Simply wonderful!
> >>
> >> Which is ~equal to .. unpack tarfile.tar to /dir/to/mnt :o)
> > if the tarfile.tar contain huge little file and unpack it will cost
> > time and much disk space.
> 
> 1) This tarfs code have only RO support. Prepare RW acces for tar nball
>     file structure will not be so trivial.
> 2) If You want save disk space for small files with also RO access
>     only better will be spend some time on romfs for extend them for allow
>     operate on slightly bigger file systeme than curreent lmitation this fs.
>     Packing to tar file will be functionaly equal to generate romfs image
>     using genromfs.
> 3) Maybe I'm wrong but IIRC raiserfs have block suballocation. If I'm
>     wrong (about current raiserfs) btter will be write and use some fs with
>     this kind feacture.
> 4) Huge or very huge amout of small files it is usulaly case on filesystem
>     for mail spool. It need RW access. Subject was many tilme in past
>     discussed and can be find on archives aroud mailfs or mailstorfs
>     words. Tar ball structure isn't specialized for allow fast RW operation.
>     In cases where speed isn't issue tarfs will be fuctional equivalet to romfs.
> 
> Count of cases where tarfs will be useable will be probably very close to 
> cout of cases where romfs is used now. All without add single line of code 
> on kernel level :-)
> 
> tarfs it is *good* code example but IMO .. only example :_)
> 
> kloczek
> -- 
> -----------------------------------------------------------
> *Ludzie nie maj± problemów, tylko sobie sami je stwarzaj±*
> -----------------------------------------------------------
> Tomasz K³oczko, sys adm @zie.pg.gda.pl|*e-mail: kloczek@rudy.mif.pg.gda.pl*
