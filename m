Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262001AbTKRBA1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 20:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262283AbTKRBAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 20:00:21 -0500
Received: from gaia.cela.pl ([213.134.162.11]:22277 "EHLO gaia.cela.pl")
	by vger.kernel.org with ESMTP id S262001AbTKRBAO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 20:00:14 -0500
Date: Tue, 18 Nov 2003 02:00:01 +0100 (CET)
From: Maciej Zenczykowski <maze@cela.pl>
To: Keith Whyte <keith@media-solutions.ie>
cc: Edgar Toernig <froese@gmx.de>, <linux-kernel@vger.kernel.org>,
       <linux-gcc@vger.kernel.org>, <linux-admin@vger.kernel.org>
Subject: Re: 2.4.18 fork & defunct child.
In-Reply-To: <3FB96718.20103@media-solutions.ie>
Message-ID: <Pine.LNX.4.44.0311180151490.11042-100000@gaia.cela.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> { strace listing deleted, see 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=106905386725308&w=2 }

well, I strace'd by glibc 2.3.2 system /bin/true and it doesn't fork and 
doesn't open proc (first place the two straces differ).  Maybe your 
libraries have been hacked - seems the most likely to me - if this is 
happening for all programs than the libc is likely bad...

I can't understand what it is opening /proc/.../exe for and I don't 
understand what the ///////// in there is for (I think more than 2 
consecutive slashes are illegal in POSIX, not sure though, never use more 
than 2 :) )

On a side note /bin/true should take up somewhere like 10 bytes asm code - 
what the hell is that thing doing more than exit(1) for? it shouldn't open 
any files at all... what a bad design (and true --help and true --version 
don't work anyway... duh!)

perhaps try ltrace'ing /bin/true and see what that prints out?

Cheers,
MaZe.



