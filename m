Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266363AbSLOLRM>; Sun, 15 Dec 2002 06:17:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266368AbSLOLRM>; Sun, 15 Dec 2002 06:17:12 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:52746 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S266363AbSLOLRL>;
	Sun, 15 Dec 2002 06:17:11 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: abindus@wanadoo.fr
Cc: linux-kernel@vger.kernel.org
Subject: Re: compilation failure 
In-reply-to: Your message of "Wed, 11 Dec 2002 23:22:55 BST."
             <3DF7BABF.6080008@wanadoo.fr> 
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Date: Sun, 15 Dec 2002 22:24:50 +1100
Message-ID: <937.1039951490@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Dec 2002 23:22:55 +0100, 
abindus@wanadoo.fr wrote:
>It seems to complain of not founding some libraries
>After the make dep, make bzImage gives (I'm sorry but it's in french) :
>/usr/src/linux-2.4.18-18.8.0/include/linux/kernel.h:10:20: stdarg.h: 
>Aucun fichier ou répertoire de ce type
>Dans le fichier inclus à partir de 

Look in Makefile, find a line like this

kbuild_2_4_nostdinc    := -nostdinc $(shell $(CC) -print-search-dirs | sed -ne 's/install: \(.*\)/-I \1include/gp')

Change '$(CC)' to 'LANG=C $(CC)'.

The standard 2.4.18 kernel does not use -nostdinc but RH have
backported the patch from 2.4.19.

