Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934372AbWK2GGU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934372AbWK2GGU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 01:06:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934384AbWK2GGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 01:06:20 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:60105 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S934372AbWK2GGT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 01:06:19 -0500
Date: Tue, 28 Nov 2006 22:06:33 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: akpm <akpm@osdl.org>, perex@suse.cz
Subject: [PATCH -mm] ALSA: add struct forward declaration
Message-Id: <20061128220633.850e5051.randy.dunlap@oracle.com>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <randy.dunlap@oracle.com>

I see about 10 sets of these in a random config.

  CC      drivers/media/video/saa7134/saa7134-cards.o
In file included from drivers/media/video/saa7134/saa7134.h:43,
                 from drivers/media/video/saa7134/saa7134-cards.c:27:
include/sound/pcm.h:59: warning: 'struct snd_pcm_substream' declared inside parameter list
include/sound/pcm.h:59: warning: its scope is only this definition or declaration, which is probably not what you want
include/sound/pcm.h:60: warning: 'struct snd_pcm_substream' declared inside parameter list
include/sound/pcm.h:62: warning: 'struct snd_pcm_substream' declared inside parameter list
include/sound/pcm.h:64: warning: 'struct snd_pcm_substream' declared inside parameter list
include/sound/pcm.h:65: warning: 'struct snd_pcm_substream' declared inside parameter list
include/sound/pcm.h:66: warning: 'struct snd_pcm_substream' declared inside parameter list
include/sound/pcm.h:67: warning: 'struct snd_pcm_substream' declared inside parameter list
include/sound/pcm.h:68: warning: 'struct snd_pcm_substream' declared inside parameter list
include/sound/pcm.h:71: warning: 'struct snd_pcm_substream' declared inside parameter list
include/sound/pcm.h:73: warning: 'struct snd_pcm_substream' declared inside parameter list
include/sound/pcm.h:75: warning: 'struct snd_pcm_substream' declared inside parameter list
include/sound/pcm.h:76: warning: 'struct snd_pcm_substream' declared inside parameter list
include/sound/pcm.h:77: warning: 'struct snd_pcm_substream' declared inside parameter list

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 include/sound/pcm.h |    2 ++
 1 file changed, 2 insertions(+)

--- linux-2.6.19-rc6-mm2.orig/include/sound/pcm.h
+++ linux-2.6.19-rc6-mm2/include/sound/pcm.h
@@ -55,6 +55,8 @@ struct snd_pcm_hardware {
 	size_t fifo_size;		/* fifo size in bytes */
 };
 
+struct snd_pcm_substream;
+
 struct snd_pcm_ops {
 	int (*open)(struct snd_pcm_substream *substream);
 	int (*close)(struct snd_pcm_substream *substream);


---
