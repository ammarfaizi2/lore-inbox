Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316976AbSFABpA>; Fri, 31 May 2002 21:45:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316977AbSFABo7>; Fri, 31 May 2002 21:44:59 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:42128 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S316976AbSFABo7>; Fri, 31 May 2002 21:44:59 -0400
Date: Fri, 31 May 2002 20:44:59 -0500 (CDT)
From: Kai Germaschewski <kai-germaschewski@uiowa.edu>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Edouard Gomez <ed.gomez@wanadoo.fr>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [small BUG] Makefile bug with gcc 3.1 and non english locales
In-Reply-To: <20020601013320.GA9616@wanadoo.fr>
Message-ID: <Pine.LNX.4.44.0205312042570.18762-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Jun 2002, Edouard Gomez wrote:

> kbuild_2_4_nostdinc	:= -nostdinc $(shell $(CC) -print-search-dirs | sed -ne 's/install: \(.*\)/-I \1include/gp')

Russell King suggested the following nice construct, which I'll submit for 
2.5 shortly. It should work for you, too.

> CFLAGS	+= -nostdinc -iwithprefix include
> 
> `-iwithprefix DIR'
>     Add a directory to the second include path.  The directory's name
>     is made by concatenating PREFIX and DIR, where PREFIX was
>     specified previously with `-iprefix'.  If you have not specified a
>     prefix yet, the directory containing the installed passes of the
>     compiler is used as the default.

--Kai

