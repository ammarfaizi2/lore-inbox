Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271994AbRHVMUq>; Wed, 22 Aug 2001 08:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271995AbRHVMUh>; Wed, 22 Aug 2001 08:20:37 -0400
Received: from finch-post-10.mail.demon.net ([194.217.242.38]:60164 "EHLO
	finch-post-10.mail.demon.net") by vger.kernel.org with ESMTP
	id <S271994AbRHVMUT>; Wed, 22 Aug 2001 08:20:19 -0400
Subject: Re: PROBLEM: NTFS  routine fs/ntfs/unistr.c does not compile
From: Richard Russon <rich@flatcap.org>
To: Harald von Fellenberg <harald.von-fellenberg@sun.com>
Cc: aia21@cus.cam.ac.uk, linux-ntfs-dev@lists.sourceforge.net,
        lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3B834ADD.3A466F48@sun.com>
In-Reply-To: <3B834ADD.3A466F48@sun.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12.99+cvs.2001.08.20.07.08 (Preview Release)
Date: 22 Aug 2001 13:20:25 +0100
Message-Id: <998482825.1795.4.camel@home.flatcap.org>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Harald,

> [1.] NTFS  routine fs/ntfs/unistr.c does not compile
> [2.] NTFS  routine fs/ntfs/unistr.c does not compile: the macro
> min(a,b,c) is not defined.

Yep.

> Comparison with Linux 2.4.7 revealed that
>      1. the pertaining line in unistr.c has changed from 2.4.7 to 2.4.9
>      2. the macro definition in file fs/ntfs/macros.h for macro min()
> has been dropped

Actually all the min/max macros have (finally) been moved to kernel.h.

>      The solution was straight forward: add the (three-parameter) macro
>      definition from include/linux/kernel.h to fs/ntfs/macros.h
>      The patch is added below

The correct solution is to add the following to unistr.c:

  #include <linux/kernel.h>

Cheers,
  FlatCap (Rich)
  ntfs@flatcap.org


