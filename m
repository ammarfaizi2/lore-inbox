Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263406AbTI2OB4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 10:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263419AbTI2OB4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 10:01:56 -0400
Received: from gate.perex.cz ([194.212.165.105]:46043 "EHLO gate.perex.cz")
	by vger.kernel.org with ESMTP id S263406AbTI2OBy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 10:01:54 -0400
Date: Mon, 29 Sep 2003 16:01:09 +0200 (CEST)
From: Jaroslav Kysela <perex@suse.cz>
X-X-Sender: perex@pnote.perex-int.cz
To: Muli Ben-Yehuda <mulix@mulix.org>
Cc: Florin Iucha <florin@iucha.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.0-test6
In-Reply-To: <20030929135540.GO29313@actcom.co.il>
Message-ID: <Pine.LNX.4.53.0309291558550.1362@pnote.perex-int.cz>
References: <Pine.LNX.4.44.0309271822450.6141-100000@home.osdl.org>
 <20030929132355.GA1206@iucha.net> <20030929135540.GO29313@actcom.co.il>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Sep 2003, Muli Ben-Yehuda wrote:

> On Mon, Sep 29, 2003 at 08:23:55AM -0500, Florin Iucha wrote:
>
> > I can no longer select my soundcard: In test5 it was configured by
> > CONFIG_SND_CS46XX! This option is no longer available in test6 (make
> > menuconfig does not offer me the opportunity).
>
> You need to enable CONFIG_GAMEPORT, or apply this patch. Jaroslav, is
> there a master plan for the CONFIG_SOUND_GAMEPORT -> CONFIG_GAMEPORT
> conversion or is it a bug? this patch reverts it.

CONFIG_SOUND_GAMEPORT define is ugly. It's better to remove all gameport
dependencies from the ALSA's configuration files and let drivers to
detect the gameport presence at "compile" time.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs
