Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316667AbSFABd3>; Fri, 31 May 2002 21:33:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316670AbSFABd2>; Fri, 31 May 2002 21:33:28 -0400
Received: from smtp-out-6.wanadoo.fr ([193.252.19.25]:46810 "EHLO
	mel-rto6.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S316667AbSFABd1>; Fri, 31 May 2002 21:33:27 -0400
Date: Sat, 1 Jun 2002 03:33:20 +0200
From: Edouard Gomez <ed.gomez@wanadoo.fr>
To: lkml <linux-kernel@vger.kernel.org>
Subject: [small BUG] Makefile bug with gcc 3.1 and non english locales
Message-ID: <20020601013320.GA9616@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

well, if i use gcc 3.1 with the current Makefile, the gcc specific include
dir is not well parsed in this expression :

kbuild_2_4_nostdinc	:= -nostdinc $(shell $(CC) -print-search-dirs | sed -ne 's/install: \(.*\)/-I \1include/gp')

because my system is fr_FR and the gcc output begins with :

Installé: ...

So i have to put LC_ALL=C before compiling the kernel.

I think you should set LC_ALL=C in the Makefile in order to avoid that
problem with locales.

Regards

PS : Please CC me the answers.

-- 
Edouard Gomez
