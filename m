Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161104AbWJRPSH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161104AbWJRPSH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 11:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161168AbWJRPSH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 11:18:07 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:61357 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1161104AbWJRPSE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 11:18:04 -0400
Date: Wed, 18 Oct 2006 17:14:59 +0200
From: Joerg.Schilling@fokus.fraunhofer.de (Joerg Schilling)
To: schilling@fokus.fraunhofer.de, linux-kernel@vger.kernel.org,
       kronos.it@gmail.com, ismail@pardus.org.tr, 7eggert@gmx.de
Subject: Re: Linux ISO-9660 Rock Ridge bug needs fix
Message-ID: <453644f3.0BzwxliMKAw+rSMj%Joerg.Schilling@fokus.fraunhofer.de>
References: <771eN-VK-9@gated-at.bofh.it>
 <771yn-1XU-65@gated-at.bofh.it> <E1GZy4L-00015O-AV@be1.lrz>
In-Reply-To: <E1GZy4L-00015O-AV@be1.lrz>
User-Agent: nail 11.22 3/20/05
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bodo Eggert <7eggert@elstempel.de> wrote:

> Luca Tettamanti <kronos.it@gmail.com> wrote:
>
> > +++ b/fs/isofs/rock.c
>
> > +
> > +                     /* Rock Ridge V1.12, override inode number */
> > +                     if (rr->len == 44)
> > +                             inode->i_ino = isonum_733(rr->u.PX.inode);
>
> I think it's wrong again, it will break as soon as rockridge 1.13 defines
> an additional field. s,==,>=, should do the trick.
>
> BTW and without digging in the code: Since version 2 will be binary
> incompatible, is there a version check?

There is de-facto no consistency check on Linux.
It would be easy to create special ISO images that cause Linux to panic from 
many other places in the ISO-9660 code.


> BTW2, Just to be cautionous: what will happen if somebody forces the same
> inode number on two different entries?

What happenes when somebody set the traffic light to "green" in all directions?

What happenes if someone sets the same inode number for different files on UDF?

This is something you cannot check.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
