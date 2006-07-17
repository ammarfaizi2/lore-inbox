Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751032AbWGQQkK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751032AbWGQQkK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 12:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750976AbWGQQjo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 12:39:44 -0400
Received: from mail.kroah.org ([69.55.234.183]:38076 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750979AbWGQQdf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 12:33:35 -0400
Date: Mon, 17 Jul 2006 09:28:51 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, Takashi Iwai <tiwai@suse.de>,
       Jaroslav Kysela <perex@suse.cz>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 36/45] ALSA: Fix undefined (missing) references in ISA MIRO sound driver
Message-ID: <20060717162851.GK4829@kroah.com>
References: <20060717160652.408007000@blue.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="alsa-fix-undefined-references-in-isa-miro-sound-driver.patch"
In-Reply-To: <20060717162452.GA4829@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Takashi Iwai <tiwai@suse.de>

[PATCH] ALSA: Fix undefined (missing) references in ISA MIRO sound driver

WARNING: /lib/modules/2.6.18-rc1-mm1/kernel/sound/isa/opti9xx/snd-miro.ko needs unknown symbol snd_cs4231_create
WARNING: /lib/modules/2.6.18-rc1-mm1/kernel/sound/isa/opti9xx/snd-miro.ko needs unknown symbol snd_cs4231_pcm
WARNING: /lib/modules/2.6.18-rc1-mm1/kernel/sound/isa/opti9xx/snd-miro.ko needs unknown symbol snd_cs4231_timer
WARNING: /lib/modules/2.6.18-rc1-mm1/kernel/sound/isa/opti9xx/snd-miro.ko needs unknown symbol snd_cs4231_mixer
WARNING: /lib/modules/2.6.18-rc1-mm1/kernel/fs/reiser4/reiser4.ko needs unknown symbol generic_file_read

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Jaroslav Kysela <perex@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 sound/isa/cs423x/Makefile |    1 +
 1 file changed, 1 insertion(+)

--- linux-2.6.17.6.orig/sound/isa/cs423x/Makefile
+++ linux-2.6.17.6/sound/isa/cs423x/Makefile
@@ -11,6 +11,7 @@ snd-cs4236-objs := cs4236.o
 
 # Toplevel Module Dependency
 obj-$(CONFIG_SND_AZT2320) += snd-cs4231-lib.o
+obj-$(CONFIG_SND_MIRO) += snd-cs4231-lib.o
 obj-$(CONFIG_SND_OPL3SA2) += snd-cs4231-lib.o
 obj-$(CONFIG_SND_CS4231) += snd-cs4231.o snd-cs4231-lib.o
 obj-$(CONFIG_SND_CS4232) += snd-cs4232.o snd-cs4231-lib.o

--
