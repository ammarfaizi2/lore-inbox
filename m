Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314938AbSFXTIC>; Mon, 24 Jun 2002 15:08:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315120AbSFXTIB>; Mon, 24 Jun 2002 15:08:01 -0400
Received: from ns1.alcove-solutions.com ([212.155.209.139]:8104 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S314938AbSFXTIA>; Mon, 24 Jun 2002 15:08:00 -0400
Date: Mon, 24 Jun 2002 21:07:40 +0200
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.4.19-rc1] BLK_DEV_RAM not BLOCK_DEV_RAM. was: Linux 2.4.19-rc1
Message-ID: <20020624190740.GA19095@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0206241253120.9274-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0206241253120.9274-100000@freak.distro.conectiva>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 24, 2002 at 12:58:23PM -0300, Marcelo Tosatti wrote:

> Directly from OLS you're getting the first release candidate.
> 
> Please test it extensively.

Hi Marcelo,

The attached patch I've send you against the pre10 is still needed
to fix a typo.

Please apply.

Stelian.

> From stelian.pop@fr.alcove.com Fri Jun  7 12:04:45 2002
> Date: Fri, 7 Jun 2002 12:04:45 +0200

This trivial patch is necessary to compile the current bk head
when one does not have a floppy device...

Thanks,

Stelian.

===== init/do_mounts.c 1.26 vs edited =====
--- 1.26/init/do_mounts.c	Tue Jun  4 19:13:30 2002
+++ edited/init/do_mounts.c	Fri Jun  7 10:51:37 2002
@@ -378,7 +378,7 @@
 	return sys_symlink(path + n + 5, name);
 }
 
-#if defined(CONFIG_BLOCK_DEV_RAM) || defined(CONFIG_BLK_DEV_FD)
+#if defined(CONFIG_BLK_DEV_RAM) || defined(CONFIG_BLK_DEV_FD)
 static void __init change_floppy(char *fmt, ...)
 {
 	struct termios termios;
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
