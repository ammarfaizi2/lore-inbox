Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750820AbWJQW1e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820AbWJQW1e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 18:27:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbWJQW1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 18:27:34 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:13186 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1750820AbWJQW1d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 18:27:33 -0400
Date: Wed, 18 Oct 2006 00:24:28 +0200
From: Joerg.Schilling@fokus.fraunhofer.de (Joerg Schilling)
To: jlamanna@gmail.com
Cc: schilling@fokus.fraunhofer.de, linux-kernel@vger.kernel.org,
       ismail@pardus.org.tr
Subject: Re: Linux ISO-9660 Rock Ridge bug needs fix
Message-ID: <4535581c.0EJOm7ejIJzKFKJj%Joerg.Schilling@fokus.fraunhofer.de>
References: <4535460c.5a4933ac.778b.ffffc157@mx.google.com>
 <45354bf7.Lo5w3vkS8/cH+1PI%Joerg.Schilling@fokus.fraunhofer.de>
 <aa4c40ff0610171451l5597dc55i97fcad4cf111acd2@mail.gmail.com>
In-Reply-To: <aa4c40ff0610171451l5597dc55i97fcad4cf111acd2@mail.gmail.com>
User-Agent: nail 11.22 3/20/05
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"James Lamanna" <jlamanna@gmail.com> wrote:

> > the wrong way.... because the error text is wrong. It should be corrected into
> >
> > "rock: directory entry would _underflow_ storage\n"
>
> Yes I saw this check and misinterpreted it initially also.
>
> I actually think 'overflow' is still correct since its testing for the
> calcuated size (directory entry) being larger than the size reported
> by the filesystem (storage).
>
> I still submit my patch to Linus et. al. for consideration that also
> detects overflow in the case of a v 1.12 PX entry. I may have time to
> build a git kernel today or tomorrow and actually test it against a RR
> iso image.

If you test for the case that the on disk structure is bigger than expected, 
then you break the RR standard.


> > Using the inode field from RRip 1.12 is definitely not trivial as it may affect
> > many parts of the source and needs intensive testing.
>
> Yes. If it is actually correct it allows for the use of iget_locked()
> in isofs/inode.c instead of iget5_locked() (per
> Documentation/filesystems/vfs.txt). Though I'll let a real VFS person
> decide if that has any advantages.

This is not true, the inode numbe is not sufficient to identify a file.

But if you are not a fs expert, you should not continue....

Maging this change work for trivial cases will take an hour, making it work
for the non-obvious cases may take more than a week.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
