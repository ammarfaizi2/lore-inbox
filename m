Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310228AbSCLAEt>; Mon, 11 Mar 2002 19:04:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310227AbSCLAEk>; Mon, 11 Mar 2002 19:04:40 -0500
Received: from jalon.able.es ([212.97.163.2]:61407 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S310212AbSCLAEe>;
	Mon, 11 Mar 2002 19:04:34 -0500
Date: Tue, 12 Mar 2002 01:04:24 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.19-pre3
Message-ID: <20020312000424.GC2300@werewolf.able.es>
In-Reply-To: <Pine.LNX.4.21.0203111805480.2492-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.21.0203111805480.2492-100000@freak.distro.conectiva>; from marcelo@conectiva.com.br on lun, mar 11, 2002 at 22:08:19 +0100
X-Mailer: Balsa 1.3.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.03.11 Marcelo Tosatti wrote:
>
>Hi, 
>
>Please stress test it with huge amounts of data ;)
>
>pre3:
>
>- aic7xxx update					(Justin T. Gibbs)
>- Do not consider SCSI recovered errors as fatal errors	(Justin T. Gibbs)

Sure ?

werewolf:~/soft/kernel# grep aic7xxx patch-2.4.19-pre3
diff -Naur -X /home/marcelo/lib/dontdiff linux.orig/drivers/scsi/aic7xxx/aic7xxx.c linux/drivers/scsi/aic7xxx/aic7xxx.c
--- linux.orig/drivers/scsi/aic7xxx/aic7xxx.c   Thu Oct 25 20:53:48 2001
+++ linux/drivers/scsi/aic7xxx/aic7xxx.c        Thu Feb 28 17:50:49 2002

Just this hunk is present:

diff -Naur -X /home/marcelo/lib/dontdiff linux.orig/drivers/scsi/aic7xxx/aic7xxx.c linux/drivers/scsi/aic7xxx/aic7xxx.c
--- linux.orig/drivers/scsi/aic7xxx/aic7xxx.c   Thu Oct 25 20:53:48 2001
+++ linux/drivers/scsi/aic7xxx/aic7xxx.c    Thu Feb 28 17:50:49 2002
@@ -2584,7 +2584,7 @@

        /*
         * Read the latched byte, but turn off SPIOEN first
-        * so that we don't inadvertantly cause a REQ for the
+        * so that we don't inadvertently cause a REQ for the
         * next byte.
         */
        ahc_outb(ahc, SXFRCTL0, ahc_inb(ahc, SXFRCTL0) & ~SPIOEN);

Nice update ;)...

BTW, this applies cleanly:

http://giga.cps.unizar.es/~magallon/linux/kernel/2.4.19-pre2-jam5/30-aic7xxx-6.2.5.gz


-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.2 (Cooker) for i586
Linux werewolf 2.4.19-pre2-jam5 #1 SMP Mon Mar 11 16:08:11 CET 2002 i686
