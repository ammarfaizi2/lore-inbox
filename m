Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129509AbRCPDxO>; Thu, 15 Mar 2001 22:53:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129638AbRCPDxF>; Thu, 15 Mar 2001 22:53:05 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:518 "HELO
	postfix.conectiva.com.br") by vger.kernel.org with SMTP
	id <S129509AbRCPDww>; Thu, 15 Mar 2001 22:52:52 -0500
Date: Thu, 15 Mar 2001 23:07:44 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: "Donald J. Barry" <don@astro.cornell.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel paging oops on massive vfs activity
In-Reply-To: <200103141939.OAA05598@isc4.tn.cornell.edu>
Message-ID: <Pine.LNX.4.21.0103152303020.4543-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 14 Mar 2001, Donald J. Barry wrote:

> Hey kernel developers,
> 
> I'm getting repeated oopses and occasional freezes on a server I've
> set up to host a giant (180G) reiserfs system atop lvm, served by nfs(v2).
> (I've applied the reiserfs and nfs patches to the vanilla kernel,
> which is otherwise pretty minimally compiled). They seem to be
> correlated by massive disk activity.  Because this file system has
> many huge directories (20000+ files in some) and also many long names
> (some of those giant directories are filled with 40+ character
> filenames) I'm beginning to wonder whether the vfs layer is at fault.
> I got some of the same behavior with an earlier ext2 instance atop
> lvm.  In this case I triggered the result by doing a find atop the 
> tree.  Generally things that access many directory entries trigger it.
> 
> Of course, it could be a remaining hardware glitch on this new tbird
> 1100 system on GA59X motherboard (latest firmware, but it has the 
> troublesome VIA kt133 chipset).
> 
> What use is a server when it oopses when trying to serve?
>
> Any thoughts?

Seems to be inode hash list corruption.

Maybe bad memory. 
  
Can you use the "memtest86" utility to check if your memory is OK? (you
can find it at www.freshmeat.net)


