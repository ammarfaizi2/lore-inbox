Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261297AbSIPKWX>; Mon, 16 Sep 2002 06:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261334AbSIPKWX>; Mon, 16 Sep 2002 06:22:23 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:57071 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S261297AbSIPKWX>; Mon, 16 Sep 2002 06:22:23 -0400
X-Mailer: exmh version 2.5 13/07/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.NEB.4.44.0209161206590.14886-100000@mimas.fachschaften.tu-muenchen.de> 
References: <Pine.NEB.4.44.0209161206590.14886-100000@mimas.fachschaften.tu-muenchen.de> 
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.35 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 16 Sep 2002 11:27:15 +0100
Message-ID: <3417.1032172035@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


bunk@fs.tum.de said:
>  Since 2.5.34 the compilation of JFFS2 fails with a compile error
> similar to the one in JFFS: 

Yeah. Somebody changed the prototype of dequeue_signal() and even though 
there are few users evidently didn't bother to fix them accordingly.

Current JFFS2 code depends on some fairly trivial rbtree updates which Linus
keeps ignoring without comment. Once those are in, I can update the JFFS2
code in 2.5 too, and will take a look if whoever broke it hasn't got around
to testing (or even compiling) their changes by then.

--
dwmw2


