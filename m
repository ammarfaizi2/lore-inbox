Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311748AbSCNThy>; Thu, 14 Mar 2002 14:37:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311747AbSCNThp>; Thu, 14 Mar 2002 14:37:45 -0500
Received: from gate.perex.cz ([194.212.165.105]:7433 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id <S311748AbSCNThb> convert rfc822-to-8bit;
	Thu, 14 Mar 2002 14:37:31 -0500
Date: Thu, 14 Mar 2002 20:37:16 +0100 (CET)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: <perex@pnote.perex-int.cz>
To: =?iso-8859-15?q?J=F6rg=20Prante?= <joergprante@gmx.de>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ALSA and IrDA workaround for Dell Inspiron
In-Reply-To: <200203141527.AUR63833@netmail.netcologne.de>
Message-ID: <Pine.LNX.4.33.0203142034530.591-100000@pnote.perex-int.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Mar 2002, [iso-8859-15] Jörg Prante wrote:

> 
> Here is a patch to solve an IrDA lockup when ALSA OSS is used with IrDA on 
> Dell Inspiron 8100. Maybe some other laptops are concerned, too. Please test 
> if other machines can use this patch.
> 
> The ALSA OSS initialization code performs a hard reset on the IrDA port of a 
> Dell Inspiron. No more data can be sent or received via the infrared port 
> until a cold restart of the system (power down). The lockup will always 
> happen when ALSA is started after IrDA which is normally the case. 
> 
> I found the ALSA OSS AC97 modem probe is the reason. This patch enables a 
> workaround by a kernel option CONFIG_SOUND_NO_MODEM_PROBE which 
> disables the modem probe if the option is enabled.
> 
> The patch will be included in my upcoming kernel patch set -jp8.
> 
> Please reply with CC since I am not subscribed to the Linux kernel mailing 
> list.

A small note: The directory linux/sound/oss contains only OSS sources
moved from linux/drivers/sound. They are not related with ALSA in any way.
ALSA AC97 codec routines don't touch modem registers at all.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com


