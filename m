Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263199AbSJCIPZ>; Thu, 3 Oct 2002 04:15:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263203AbSJCIPZ>; Thu, 3 Oct 2002 04:15:25 -0400
Received: from AGrenoble-101-1-1-129.abo.wanadoo.fr ([193.251.23.129]:58894
	"EHLO microsoft.com") by vger.kernel.org with ESMTP
	id <S263199AbSJCIPY> convert rfc822-to-8bit; Thu, 3 Oct 2002 04:15:24 -0400
Subject: Re: RfC: Don't cd into subdirs during kbuild
From: Xavier Bestel <xavier.bestel@free.fr>
To: Kai Germaschewski <kai-germaschewski@uiowa.edu>
Cc: kbuild-devel@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0210022153090.10307-100000@chaos.physics.uiowa.edu>
References: <Pine.LNX.4.44.0210022153090.10307-100000@chaos.physics.uiowa.edu>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.8 
Date: 03 Oct 2002 10:21:09 +0200
Message-Id: <1033633277.27227.2.camel@nomade>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeu 03/10/2002 à 04:59, Kai Germaschewski a écrit :
> 
> Hi,
> 
> I'd appreciate to get comments on the appended patch. It's mostly cleanups 
> and the like, but the interesting part is the last cset, which is actually
> fairly small:
> 
>  14 files changed, 64 insertions(+), 47 deletions(-)
> 
> The build process remains recursive, but it changes the recursion
> from 
> 
> 	make -C subdir
> 
> to
> 
> 	make -f subdir/Makefile

Could you do instead:

	include subdir/Makefile
?

This would avoid recursive make, which isn't really a good idea (even if
it's used widely). Here is a good agument about that:
http://www.cse.iitb.ac.in/~soumen/teach/cs699a1999/make.html


