Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266376AbUHSQEq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266376AbUHSQEq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 12:04:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266585AbUHSQEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 12:04:46 -0400
Received: from tag.witbe.net ([81.88.96.48]:11454 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id S266376AbUHSQDQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 12:03:16 -0400
Message-Id: <200408191600.i7JG0Sq25765@tag.witbe.net>
Reply-To: <rol@as2917.net>
From: "Paul Rolland" <rol@as2917.net>
To: <gene.heskett@verizon.net>, <linux-kernel@vger.kernel.org>
Cc: "'Matthias Andree'" <matthias.andree@gmx.de>, "'Martin Mares'" <mj@ucw.cz>,
       "'Joerg Schilling'" <schilling@fokus.fraunhofer.de>,
       <kernel@wildsau.enemy.org>, <diablod3@gmail.com>
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Date: Thu, 19 Aug 2004 18:00:27 +0200
Organization: AS2917
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <200408191136.49766.gene.heskett@verizon.net>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
thread-index: AcSGA28WJFfyQyMDQ762MpRzUWWDJwAAd1QQ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> FWIW, I had to use smake, latest version from his site, in order to 
> compile 2.01a37 just yesterday.  The error messages from make (very 
> carefully programmed into the Makefile) indicated that the lost 
> headers it couldn't find were a bug in make-3.80, and that his make 
> suffered from no such errors.  It didn't.
> 
> Since the gnu make has only had, what, 2, maybe 3 revisions in almost 
> a decade, maybe, just maybe, there is a grain of truth to Jorg's 
> objections and often childish squawking, at least over the gnu make 
> which he has mentioned, among others.

I did compile the cdrecord 2.01a37 on my machine no later than 
yesterday.
I was running my 2.6.8.1 kernel, and make says :
GNU Make version 3.79.1, by Richard Stallman and Roland McGrath.
Built for i386-redhat-linux-gnu
Copyright (C) 1988, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 2000
        Free Software Foundation, Inc.
This is free software; see the source for copying conditions.
There is NO warranty; not even for MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE.

Report bugs to <bug-make@gnu.org>.

Build process was really fine, no error was reported, and I don't have
any smake stuff on my machine :
17 [17:58] rol@donald:~/install/cdrtools-2.01a37> smake
smake: Command not found.

 
> [root@coyote cdrecord]# cdrecord --version
> Cdrecord-Clone 2.01a37 (i686-pc-linux-gnu) Copyright (C) 1995-2004 
> Jörg Schilling
> cdrecord: Warning: Running on Linux-2.6.8-rc4
> cdrecord: There are unsettled issues with Linux-2.5 and newer.
> cdrecord: If you have unexpected problems, please try Linux-2.4 or 
> Solaris.
> 
> However Jorg, since I built from your tarball, and used smake to do 
> it, why is it now proclaiming to be a "Clone".

Seems to be only related to the -clone option if you look at the code, 
and it indicates the feature has been compile :
#ifdef  CLONE_WRITE
        error("\t-clone         Write disk in clone write mode.\n");
#endif  

Regards,
Paul

Paul Rolland, rol(at)as2917.net
ex-AS2917 Network administrator and Peering Coordinator

--

Please no HTML, I'm not a browser - Pas d'HTML, je ne suis pas un navigateur

"Some people dream of success... while others wake up and work hard at it" 



