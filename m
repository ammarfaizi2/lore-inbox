Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129057AbRBNFWQ>; Wed, 14 Feb 2001 00:22:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129108AbRBNFWG>; Wed, 14 Feb 2001 00:22:06 -0500
Received: from www.wen-online.de ([212.223.88.39]:33802 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S129057AbRBNFVw>;
	Wed, 14 Feb 2001 00:21:52 -0500
Date: Wed, 14 Feb 2001 06:21:46 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
To: Jaswinder Singh <jaswinder.singh@3disystems.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Problem with Ramdisk in linux-2.4.1 
In-Reply-To: <012101c095ff$3b167320$bba6b3d0@Toshiba>
Message-ID: <Pine.Linu.4.10.10102140605250.1077-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Feb 2001, Jaswinder Singh wrote:

> >
> > Can you point me to a cramfs generation procedure?  (never used
> > cramfs.. know where the docs are, but could use a small time warp)
> >
> 
> make ramdisk as you normally do and then compress it by gzip .

Ok, it's not a cramfs.  If you disable cramfs, it will likely
work.  There seems to be a (init order?) problem when cramfs is
enabled.  For instance, if I enable cramfs here, my minix gzipped
initrd can not mount root.. kernel tries to use reiserfs instead
for some unknown reason.  I disable cramfs and all is well.

Since the error message you posted seems to be from cramfs...

	-Mike

