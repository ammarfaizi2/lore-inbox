Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289577AbSA2MC1>; Tue, 29 Jan 2002 07:02:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289532AbSA2MA6>; Tue, 29 Jan 2002 07:00:58 -0500
Received: from [195.66.192.167] ([195.66.192.167]:17427 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S289629AbSA2MAh>; Tue, 29 Jan 2002 07:00:37 -0500
Message-Id: <200201291140.g0TBecE28017@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Borsenkow Andrej <Andrej.Borsenkow@mow.siemens.ru>,
        Richard Gooch <rgooch@ras.ucalgary.ca>
Subject: Re: [PATCH] KERN_INFO for devfs
Date: Tue, 29 Jan 2002 13:40:39 -0200
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <000701c1a8b1$2f493850$21c9ca95@mow.siemens.ru>
In-Reply-To: <000701c1a8b1$2f493850$21c9ca95@mow.siemens.ru>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Why do you think they _have to_ have "none"? Is it POSIXized or
> > otherwise standardized? Where can I RTFM?
>
> I do not think they have to. They just are :-)
>
> fs/namespace.c:show_vfsmnt()
>
> ...
> mangle(m, mnt->mnt_devname ? mnt->mnt_devname : "none");
>
>
> I find this convention quite useful. It allows any program to easily
> skip virtual filesystems. Using something like /dev or devfs in this
> case does not add any bit of useful information but possibly adds to
> confusion.

Maybe you're right. It's up to maintainer to decide.
Richard, do you need updated patch without "none" -> "devfs"?
--
vda
