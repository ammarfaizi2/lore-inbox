Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161148AbWJRPKh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161148AbWJRPKh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 11:10:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161147AbWJRPKh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 11:10:37 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:5802 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1161148AbWJRPKf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 11:10:35 -0400
Date: Wed, 18 Oct 2006 17:07:22 +0200
From: Joerg.Schilling@fokus.fraunhofer.de (Joerg Schilling)
To: jlamanna@gmail.com
Cc: schilling@fokus.fraunhofer.de, linux-kernel@vger.kernel.org,
       ismail@pardus.org.tr
Subject: Re: Linux ISO-9660 Rock Ridge bug needs fix
Message-ID: <4536432a.Rc5SqcjpwqAoF4au%Joerg.Schilling@fokus.fraunhofer.de>
References: <4535460c.5a4933ac.778b.ffffc157@mx.google.com>
 <45354bf7.Lo5w3vkS8/cH+1PI%Joerg.Schilling@fokus.fraunhofer.de>
 <aa4c40ff0610171451l5597dc55i97fcad4cf111acd2@mail.gmail.com>
 <4535581c.0EJOm7ejIJzKFKJj%Joerg.Schilling@fokus.fraunhofer.de>
In-Reply-To: <4535581c.0EJOm7ejIJzKFKJj%Joerg.Schilling@fokus.fraunhofer.de>
User-Agent: nail 11.22 3/20/05
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg.Schilling@fokus.fraunhofer.de (Joerg Schilling) wrote:

> > > Using the inode field from RRip 1.12 is definitely not trivial as it may affect
> > > many parts of the source and needs intensive testing.
> >
> > Yes. If it is actually correct it allows for the use of iget_locked()
> > in isofs/inode.c instead of iget5_locked() (per
> > Documentation/filesystems/vfs.txt). Though I'll let a real VFS person
> > decide if that has any advantages.
>
> This is not true, the inode number is not sufficient to identify a file.
>
> But if you are not a fs expert, you should not continue....
>
> Making this change work for trivial cases will take an hour, making it work
> for the non-obvious cases may take more than a week.

The full set of feature enhancements for Linux was to also provide "inode 
numnbers" in vanilla ISO-9660 mode and to add a fingerprint into the image so 
that the kernel is able to detect this.

Implementing support for the new inode features is supporting this mkisofs 
fingerprint as well as full testing and modifying the inode cache and NFS 
export code. For Solaris I am ready now and the code will appear soon in an 
official OpenSolaris source......



Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
