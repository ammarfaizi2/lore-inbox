Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316582AbSFKBuw>; Mon, 10 Jun 2002 21:50:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316614AbSFKBut>; Mon, 10 Jun 2002 21:50:49 -0400
Received: from zok.SGI.COM ([204.94.215.101]:52131 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S316582AbSFKBun>;
	Mon, 10 Jun 2002 21:50:43 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.21 drivers/net/hamradio/soundmodem/gentbl needs -lm
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 11 Jun 2002 11:50:36 +1000
Message-ID: <8389.1023760236@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote
>drivers/net/hamradio/soundmodem 
>/tmp/cc6m8eDA.o: In function `gentbl_offscostab': 
>/tmp/cc6m8eDA.o(.text+0x64): undefined reference to `cos' 
>... 
>Makefile uses HOST_LOADLIBES instead of HOST_LOADLIBS. That is what 
>happens when you use magic variables that cannot be syntax checked, 
>errors go undetected until somebody uses the option. 

Correction: HOST_LOADLIBES is correct, the wierd spelling threw me.

The real problem is the build system ignores HOST_LOADLIBES when
compiling programs directly from sources and not using intermediate
objects.

