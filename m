Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261512AbUJXPZL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261512AbUJXPZL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 11:25:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261515AbUJXPZL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 11:25:11 -0400
Received: from wproxy.gmail.com ([64.233.184.202]:54129 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261512AbUJXPZG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 11:25:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=R+Z9Hry1JH/KpUW2gei8dCf32FYZL3tXULJl5FZhHmlSHDeNq7tFFASBg3UQu5On5gpspR3lOYiELmPZUZTiHZoNUU6G02YvYXj19py+8Bue5kC5Ymc926pM+tdIUZErv41i8XnDK46IdoaRzMV/Jz26e+1WwjtSbZEOBrsXmU0=
Message-ID: <8f1aae7704102408255f5269c5@mail.gmail.com>
Date: Sun, 24 Oct 2004 17:25:05 +0200
From: Urs Schoenenberger <urs.schoenenberger@gmail.com>
Reply-To: Urs Schoenenberger <urs.schoenenberger@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [ALSA PATCH] 1.0.7rc2
Cc: Jaroslav Kysela <perex@suse.cz>
In-Reply-To: <Pine.LNX.4.58.0410241308190.1751@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.58.0410241308190.1751@pnote.perex-int.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Oct 2004 13:11:04 +0200 (CEST), Jaroslav Kysela
<perex@suse.cz> wrote:

> The GNU patch is available at:
> 
>   ftp://ftp.alsa-project.org/pub/kernel-patches/alsa-bk-2004-10-24.patch.gz

Hi,

for all those people out there, who, like me, just downloaded the
patch: There's a minor bug in the patch regarding sound/pci/intel8x0.c
:


@@ -64,19 +62,13 @@
 (...)
 static int buggy_irq[SNDRV_CARDS];
-#ifdef SUPPORT_JOYSTICK
-static int joystick[SNDRV_CARDS];
+static int xbox[SNDRV_CARDS];
 #endif
 #ifdef SUPPORT_MIDI
 static int mpu_port[SNDRV_CARDS]; /* disabled */

The patch removes the #ifdef SUPPORT_JOYSTICK, but the #endif is kept. 

Urs
