Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264993AbUETF5e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264993AbUETF5e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 01:57:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264997AbUETF5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 01:57:34 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:34946
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S264993AbUETF5c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 01:57:32 -0400
From: Rob Landley <rob@landley.net>
To: linux-kernel@vger.kernel.org
Subject: 2.6 kernel header licensing.
Date: Thu, 20 May 2004 00:56:40 -0500
User-Agent: KMail/1.5.4
Cc: torvalds@osdl.org, Mariusz Mazur <mmazur@kernel.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405200056.40444.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm using Mariusz Mazur's kernel headers package to compile my C library 
against, and I asked him what the license on his package was.  He said it's 
derived from the 2.6 kernel, so the license is whatever's on the 2.6 kernel.

That's the GPL.

This means that even though these are cleaned up kernel headers with kernel 
internal stuff stripped out, and designed to compile a userspace C library 
against, there's a license conflict if I use the resulting C library to 
compile anything but GPL software.  Technically, if I use them to compile BSD 
software with the advertising clause, I can't distribute the result.  The 
three P's (Perl, Python, and PHP) are right out.

Now I'm fairly certain this was not the intent.  And I could probably make a 
case in court that the intent of header files is to provide an external API 
to compile against, so the userspace portions of the kernel headers are 
pretty much by definition an external interface boundary that the GPL's terms 
won't cross.  (They define the boundary; that's what they're for.)

But I'd really rather just get this resolved politely now.

Would anybody on linux-kernel like to venture an opinion about whether the 
license on Mariusz's Mazur's kernel headers package could be changed to LGPL 
instead of GPL?  (Since that's what the LGPL is, in point of fact, for.  And 
for years the glibc people have been grabbing kernel headers and blithely 
using them to create an LGPL product with nobody complaining, and in fact 
before uclibc you couldn't have a functional linux kernel sysem without it, 
so there's a de facto license of some sort anyway that it would be nice to 
make explicit.)

The kernel headers in question can be found here:

http://ep09.pld-linux.org/~mmazur/linux-libc-headers/

Linus?  Anybody?

-- 
www.linucon.org: Linux Expo and Science Fiction Convention
October 8-10, 2004 in Austin Texas.  (I'm the con chair.)

