Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315718AbSETCod>; Sun, 19 May 2002 22:44:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315721AbSETCoc>; Sun, 19 May 2002 22:44:32 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:38049 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S315718AbSETCob>; Sun, 19 May 2002 22:44:31 -0400
Date: Sun, 19 May 2002 21:44:24 -0500 (CDT)
From: Kai Germaschewski <kai-germaschewski@uiowa.edu>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Keith Owens <kaos@ocs.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC/PATCH] improve interaction with ccache 
In-Reply-To: <1764.1021857248@kao2.melbourne.sgi.com>
Message-ID: <Pine.LNX.4.44.0205192137570.30841-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 May 2002, Keith Owens wrote:

> You are fixing the symptom, not the cause.  The symptom is too many
> compiles, people are using ccache to attempt to fix the symptom.  The
> cause is a kernel build system that forces people to make clean or
> mrproper between builds instead of reusing existing objects.

Well, I basically never do make clean or make mrproper (unless I'm playing 
with the build system itself, there it's of course necessary for testing). 

However, I do have a lot of clones of the bk trees around, used to work on 
different patches. And of course only few files differ between these 
trees, so using ccache is a big win when doing compiles in the various 
trees.

> You will find that relative include paths completely stuff up
> builds with separate source and object trees.  It will also mess up
> people who compile add on code outside the kernel tree, CURDIR is not
> related to TOPDIR.

Well, the current kbuild doesn't do separate source/object, so that's not 
an issue. If people compile out of tree things using Rules.make, you're 
right, I need to make sure to stick to the absolute path there.

--Kai

