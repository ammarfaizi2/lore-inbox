Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277338AbRKDBo3>; Sat, 3 Nov 2001 20:44:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277322AbRKDBoT>; Sat, 3 Nov 2001 20:44:19 -0500
Received: from shed.alex.org.uk ([195.224.53.219]:24993 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S277316AbRKDBoN>;
	Sat, 3 Nov 2001 20:44:13 -0500
Date: Sun, 04 Nov 2001 00:44:14 -0000
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: linux-kernel@vger.kernel.org
Cc: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: [PATCH] unterminated printk in i810_audio
Message-ID: <12220000.1004834654@araucaria>
X-Mailer: Mulberry/2.1.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Self explanatory; now I just have to work out why the timeout occurs...

--
Alex Bligh

--- /usr/src/kernel-source-2.4.13-ac7-clean/drivers/sound/i810_audio.c       Sat Nov  3 23:05:16 2001
+++ /usr/src/kernel-source-2.4.13-ac7-devel/drivers/sound/i810_audio.c        Sun Nov  4 00:34:08 2001
@@ -2505,7 +2505,7 @@
                codec->codec_write = i810_ac97_set;

                if(!i810_ac97_probe_and_powerup(card,codec)) {
-                       printk("i810_audio: timed out waiting for codec %d analog ready", num_ac97);
+                       printk("i810_audio: timed out waiting for codec %d analog ready\n", num_ac97);
                        kfree(codec);
                        break;  /* it didn't work */
                }

