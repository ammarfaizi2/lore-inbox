Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316755AbSFDVHE>; Tue, 4 Jun 2002 17:07:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316796AbSFDVHD>; Tue, 4 Jun 2002 17:07:03 -0400
Received: from rudy.mif.pg.gda.pl ([153.19.42.16]:53262 "EHLO
	rudy.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S316755AbSFDVHC>; Tue, 4 Jun 2002 17:07:02 -0400
Date: Tue, 4 Jun 2002 23:05:50 +0200 (CEST)
From: =?ISO-8859-2?Q?Tomasz_K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Austin Gonyou <austin@coremetrics.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Max groups at 32?
In-Reply-To: <3CFC367C.1080300@mandrakesoft.com>
Message-ID: <Pine.LNX.4.44L.0206042251240.14400-100000@rudy.mif.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jun 2002, Jeff Garzik wrote:

> Austin Gonyou wrote:
> 
> >I'm not sure if this is a Linux capabilities problem, a PAM problem, or
> >what, but I've noticed that If I add a user to > 32 groups...that user
> >cannot access anything in a directory owned by a group > the 32nd group.
> >  
> >
> 
> 
> Yes.  It's a hardcoded limit that requires a recompile of both the 
> kernel and glibc to change.

Few months ago was release by me shadow package with some neccessary
for this changes. From http://shadow.pld.org.pl/ChangeLog:

2001-09-01  Tomasz K³oczko  <kloczek@pld.org.pl>

        * src/groups.c, src/id.c, src/newgrp.c, src/useradd.c, src/usermod.c, libmisc/addgrps.c, NEWS:
        remove limit 32 to groups per user (the same user can belong to
        more than 32 groups) by use sysconf(_SC_NGROUPS_MAX) instead constant
        NGROUPS_MAX (patch by Radu Constantin Rendec <radu.rendec@ines.ro>)
        NOTE: it probably need testing on other system for add some conditionals
        for using sysconf(_SC_NGROUPS_MAX) or NGROUPS_MAX constant.

Some other fixes for correct displaing/handling 32bit uid/gid was after
above prepared by Thorsten Kukuk <kukuk@suse.de> and me and all was
integrated in shadow source tree. All is avalable in latest shadow 4.0.3.

kloczek
-- 
-----------------------------------------------------------
*Ludzie nie maj± problemów, tylko sobie sami je stwarzaj±*
-----------------------------------------------------------
Tomasz K³oczko, sys adm @zie.pg.gda.pl|*e-mail: kloczek@rudy.mif.pg.gda.pl*

