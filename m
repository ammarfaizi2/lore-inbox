Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261282AbSJLQ3c>; Sat, 12 Oct 2002 12:29:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261283AbSJLQ3b>; Sat, 12 Oct 2002 12:29:31 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:33292 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261282AbSJLQ3b>; Sat, 12 Oct 2002 12:29:31 -0400
Date: Sat, 12 Oct 2002 09:37:26 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
cc: linux-kernel@vger.kernel.org,
       <user-mode-linux-devel@lists.sourceforge.net>
Subject: Re: [PATCH] 2.5.42: UML build error
In-Reply-To: <877kgn7kmk.fsf@goat.bogus.local>
Message-ID: <Pine.LNX.4.44.0210120935240.1758-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 12 Oct 2002, Olaf Dietsche wrote:
> 
> This patch readds the path to scripts/fixdep in Rules.make. It doesn't
> break _my_ regular build, but I can't tell for others.

The thing is, the correct fix is to make uml (and other architectures) use 
the direct makefile approach (ie "make -f xxxxx/Makefile" instead of "make 
-C xxxxx").

All the dependencies are generated with relative paths anyway, so this 
one-liner makes the tree build, but it means that the dependencies are 
broken for uml-specific subdirectories anyway.

		Linus

