Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316426AbSEOQBc>; Wed, 15 May 2002 12:01:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316427AbSEOQBb>; Wed, 15 May 2002 12:01:31 -0400
Received: from 212.Red-80-35-44.pooles.rima-tde.net ([80.35.44.212]:3968 "EHLO
	DervishD.pleyades.net") by vger.kernel.org with ESMTP
	id <S316426AbSEOQBa>; Wed, 15 May 2002 12:01:30 -0400
Date: Wed, 15 May 2002 18:06:35 +0200
Organization: Pleyades
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: ANSIfy include/linux/a.out.h and include/linux/nls.h
Message-ID: <3CE2878B.mailDIB11BDZT@viadomus.com>
User-Agent: nail 9.29 12/10/01
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
From: DervishD <raul@pleyades.net>
Reply-To: DervishD <raul@pleyades.net>
X-Mailer: DervishD TWiSTiNG Mailer
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hello all :))

    The GCC compiler insists on ANSIfying the two files mentioned in
the subject, and I think that it should be done by the kernel
maintainers, not GCC ones.

    The little patch for 'nls.h' is to add conditional preprocessor
constructs around a typedef:

    typedef __u16 wchar_t;

   >#ifndef __cplusplus
    typedef __u16 wchar_t;
   >#endif

    The patch for 'a.out.h' is smaller, though:

   |#ifdef linux

   |#ifdef __linux__


    Well, I cannot really see why the ANSI standard is violated in
those two files, but if it is, the changes are pretty small to do...

    Raúl
