Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314404AbSESM1C>; Sun, 19 May 2002 08:27:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314409AbSESM1B>; Sun, 19 May 2002 08:27:01 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:48652 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S314404AbSESM04>; Sun, 19 May 2002 08:26:56 -0400
Subject: Re: AUDIT of 2.5.15 copy_to/from_user
To: rui.sousa@laposte.net (Rui Sousa)
Date: Sun, 19 May 2002 13:46:59 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), rusty@rustcorp.com.au (Rusty Russell),
        linux-kernel@vger.kernel.org,
        kernel-janitor-discuss@lists.sourceforge.net
In-Reply-To: <Pine.LNX.4.44.0205191405120.18395-100000@localhost.localdomain> from "Rui Sousa" at May 19, 2002 02:15:30 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E179Q5T-0003jZ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> copy_to/from_user() --> will return the number of bytes that were _not_ 
> copied. If one does not care about partially successes just use:
> 
> if (copy_to/from_user())
> 	return -EFAULT;

Yes

> __copy_to/from_user() --> the same as above, but can they actually return 
> anything other than 0? My assembler is no good and I'm not able to see if

They do the same things, but don't do any initial range checks that might
be done by access_ok before hand

