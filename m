Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262715AbTI1Sw5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 14:52:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262716AbTI1Sw5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 14:52:57 -0400
Received: from fw.osdl.org ([65.172.181.6]:11719 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262715AbTI1Swz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 14:52:55 -0400
Date: Sun, 28 Sep 2003 11:52:27 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Sam Ravnborg <sam@ravnborg.org>
cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Bernardo Innocenti <bernie@develer.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.0-test6
In-Reply-To: <20030928184642.GA1681@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.44.0309281150240.15408-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 28 Sep 2003, Sam Ravnborg wrote:
>
> Would it help to require all major[1] header files to include all the
> header files needed for them to compile?

It causes tons of extra work for the compiler if the compiler doesn't 
optimize away redundant header files (same header file being included from 
a lot of different sources).

I did the pruning in sparse, and I think at least gcc-3 does it too, but 
I'm not sure.

If so, then sure, we could just require that the header files compile 
cleanly, and for extra points verify that the end result is an empty 
object file (ie no bad declarations anywhere..).

		Linus

