Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272706AbRILIgY>; Wed, 12 Sep 2001 04:36:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272708AbRILIgO>; Wed, 12 Sep 2001 04:36:14 -0400
Received: from galba.tp1.ruhr-uni-bochum.de ([134.147.240.75]:39436 "EHLO
	galba.tp1.ruhr-uni-bochum.de") by vger.kernel.org with ESMTP
	id <S272706AbRILIgJ>; Wed, 12 Sep 2001 04:36:09 -0400
Date: Wed, 12 Sep 2001 10:36:30 +0200 (CEST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
To: David Woodhouse <dwmw2@infradead.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.2.20pre10 
In-Reply-To: <23591.1000282085@redhat.com>
Message-ID: <Pine.LNX.4.33.0109121034490.28657-100000@chaos.tp1.ruhr-uni-bochum.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Sep 2001, David Woodhouse wrote:

> alan@lxorguk.ukuu.org.uk said:
> > o	Fix null request_mode return 			(David Woodhouse) 
> 
> Is this attribution correct?

I suppose this fragment is refered to:

diff -ur linux-2.2.20-pre9.work/include/linux/kmod.h linux-2.2.20-pre10.work/include/linux/kmod.h
--- linux-2.2.20-pre9.work/include/linux/kmod.h	Wed Aug 29 01:30:13 2001
+++ linux-2.2.20-pre10.work/include/linux/kmod.h	Wed Sep 12 10:14:14 2001
@@ -13,7 +13,10 @@
 #else
 #include <linux/errno.h>
 
-#define request_module(x) do {} while(0)
+static inline int request_module(const char *name)
+{
+	return -EINVAL;
+}
 static inline int exec_usermodehelper(char *program_path, char *argv[], char *envp[])
 {
         return -EACCES;


--Kai


