Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310289AbSCGMGZ>; Thu, 7 Mar 2002 07:06:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310292AbSCGMGP>; Thu, 7 Mar 2002 07:06:15 -0500
Received: from web11804.mail.yahoo.com ([216.136.172.158]:41227 "HELO
	web11804.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S310289AbSCGMGK>; Thu, 7 Mar 2002 07:06:10 -0500
Message-ID: <20020307120609.85742.qmail@web11804.mail.yahoo.com>
Date: Thu, 7 Mar 2002 13:06:09 +0100 (CET)
From: =?iso-8859-1?q?Etienne=20Lorrain?= <etienne_lorrain@yahoo.fr>
Subject: Re: [patch] delayed disk block allocation
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> With "allocate on flush", (aka delayed allocation), file data is
> assigned a disk mapping when the data is being written out, rather than
> at write(2) time.  This has the following advantages:

  I do agree that this is a better solution than current one,
 but (even if I did not had time to test the patch), I have
 a question: How about bootloaders?

 IHMO all current bootloaders need to write to disk a "chain" of sector
 to load for their own initialisation, i.e. loading the remainning
 part of code stored on a file in one filesystem from the 512 bytes
 bootcode. This "chain" of sector can only be known once the file
 has been allocated to disk - and it has to be written on the same file,
 at its allocated space.

  So can you upgrade LILO or GRUB with your patch installed?
  It is not a so big problem (the solution being to install the
 bootloader on an unmounted filesystem with tools like e2fsprogs),
 but it seems incompatible with the current executables.

  Comment?
  Etienne.

___________________________________________________________
Do You Yahoo!? -- Une adresse @yahoo.fr gratuite et en français !
Yahoo! Mail : http://fr.mail.yahoo.com
