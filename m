Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263084AbSJBMqL>; Wed, 2 Oct 2002 08:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263085AbSJBMqK>; Wed, 2 Oct 2002 08:46:10 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:3079 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S263084AbSJBMqJ>;
	Wed, 2 Oct 2002 08:46:09 -0400
Date: Wed, 2 Oct 2002 14:51:10 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: s.stoklossa@mentopolis.de
Cc: mec@shout.net, linux-kernel@vger.kernel.org
Subject: Re: your mail
Message-ID: <20021002145110.D1369@mars.ravnborg.org>
Mail-Followup-To: s.stoklossa@mentopolis.de, mec@shout.net,
	linux-kernel@vger.kernel.org
References: <OF306CCF12.3BC6EB60-ONC1256C46.00458246@mentopolis.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <OF306CCF12.3BC6EB60-ONC1256C46.00458246@mentopolis.de>; from s.stoklossa@mentopolis.de on Wed, Oct 02, 2002 at 02:41:42PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2002 at 02:41:42PM +0200, s.stoklossa@mentopolis.de wrote:
> beim versuch, die Einstellungen von alsa aufzurufen, kam folgende FM:
> 
>  Q> ./scripts/Menuconfig: MCmenu74: command not found
> 
> grusz
> 
> Sven
Known problem, try this patch:
copy-n-pated so may not apply cleanly, try by hand.
Ps. Please in english next time.

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
