Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263083AbSJBMqF>; Wed, 2 Oct 2002 08:46:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263084AbSJBMqF>; Wed, 2 Oct 2002 08:46:05 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:28678 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S263083AbSJBMqE>;
	Wed, 2 Oct 2002 08:46:04 -0400
Date: Wed, 2 Oct 2002 14:49:29 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: ken hu <huylcn@yahoo.com>
Cc: mec@shout.net, linux-kernel@vger.kernel.org
Subject: Re: a problem report
Message-ID: <20021002144929.C1369@mars.ravnborg.org>
Mail-Followup-To: ken hu <huylcn@yahoo.com>, mec@shout.net,
	linux-kernel@vger.kernel.org
References: <20021002120647.223.qmail@web10004.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021002120647.223.qmail@web10004.mail.yahoo.com>; from huylcn@yahoo.com on Wed, Oct 02, 2002 at 05:06:47AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2002 at 05:06:47AM -0700, ken hu wrote:
> Menuconfig has encountered a possible error in one of
> the kernel's
Thanks, known problem.

Try this patch:
copy-n-pated so may not apply cleanly, try by hand.

        Sam

--- linux/sound/Config.in       2002-10-01 12:09:44.000000000 +0200
+++ linux/sound/Config.in       2002-10-01 12:21:05.000000000 +0200
@@ -31,10 +31,7 @@
 if [ "$CONFIG_SND" != "n" -a "$CONFIG_ARM" = "y" ]; then
   source sound/arm/Config.in
 fi
-if [ "$CONFIG_SND" != "n" -a "$CONFIG_SPARC32" = "y" ]; then
-  source sound/sparc/Config.in
-fi
-if [ "$CONFIG_SND" != "n" -a "$CONFIG_SPARC64" = "y" ]; then
+if [ "$CONFIG_SND" != "n" -a "$CONFIG_SPARC32" = "y" ] || [ "$CONFIG_SND" !=
"n" -a "$CONFIG_SPARC64" = "y" ] ; then
   source sound/sparc/Config.in
 fi
