Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129978AbRBAHQM>; Thu, 1 Feb 2001 02:16:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129979AbRBAHQD>; Thu, 1 Feb 2001 02:16:03 -0500
Received: from proxy.povodiodry.cz ([212.47.5.214]:38133 "HELO pc11.op.pod.cz")
	by vger.kernel.org with SMTP id <S129978AbRBAHPv>;
	Thu, 1 Feb 2001 02:15:51 -0500
From: "Vitezslav Samel" <samel@mail.cz>
Date: Thu, 1 Feb 2001 08:15:44 +0100
To: linux-kernel@vger.kernel.org
Subject: Re: Problems compiling hdparm with string.h (2.4.x)
Message-ID: <20010201081544.A29767@pc11.op.pod.cz>
In-Reply-To: <01020101280700.16535@backfire>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <01020101280700.16535@backfire>; from gjasny@wh8.tu-dresden.de on Thu, Feb 01, 2001 at 01:28:07AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi!

> I've just tried to compile hdparm v3.9 with a vanilla 2.4.1 tree.
> Gcc complained about serveral parse errors in /usr/include/linux/string.h.
> Compiling with an >=ac6 release works fine.
> Why isn't the little string.h fix not included in 2.4.1?
> 
> Regards, Gregor

	Consider this little patch to hdparm-3.9

		Cheers,
				Vita


diff -urN hdparm-3.9.orig/hdparm.c hdparm-3.9/hdparm.c
--- hdparm-3.9.orig/hdparm.c	Sat Feb  5 23:49:30 2000
+++ hdparm-3.9/hdparm.c	Thu Feb  1 08:13:06 2001
@@ -16,7 +16,7 @@
 #include <sys/times.h>
 #include <sys/types.h>
 #include <linux/hdreg.h>
-#include <linux/fs.h>
+#include <sys/mount.h>
 #include <linux/major.h>
 
 #define VERSION "v3.9"
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
