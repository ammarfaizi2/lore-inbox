Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262894AbTDFKSl (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 06:18:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262895AbTDFKSl (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 06:18:41 -0400
Received: from mail.interware.hu ([195.70.32.130]:11228 "EHLO
	mail.interware.hu") by vger.kernel.org with ESMTP id S262894AbTDFKSk (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 06:18:40 -0400
Message-ID: <3E8FF42E.3090207@cracker.hu>
Date: Sun, 06 Apr 2003 11:32:30 +0200
From: BaliHB <balihb@cracker.hu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; hu-HU; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: hu, en, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.21-pre7 ac97fix
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

THX AC!

diff -Naur tmp2/linux-2.4.20/include/linux/ac97_codec.h 
linux-2.4.20/include/linux/ac97_codec.h
--- tmp2/linux-2.4.20/include/linux/ac97_codec.h        2003-04-06 
09:57:56.000000000 +0200
+++ linux-2.4.20/include/linux/ac97_codec.h     2003-04-06 
10:06:30.000000000 +0200
@@ -222,6 +222,8 @@
         int dev_mixer;
         int type;

+       int modem:1;
+
         struct ac97_ops *codec_ops;

         /* controller specific lower leverl ac97 accessing routines */
@@ -237,6 +239,9 @@
         int stereo_mixers;
         int record_sources;

+       /* Property flags */
+       int flags;
+
         int bit_resolution;

         /* OSS mixer interface */
@@ -265,6 +270,8 @@
         int (*amplifier)(struct ac97_codec *codec, int on);
         /* Digital mode control */
         int (*digital)(struct ac97_codec *codec, int format);
+#define AC97_DELUDED_MODEM     1       /* Audio codec reports its a 
modem */
+#define AC97_NO_PCM_VOLUME     2       /* Volume control is missing 
    */
  };

  extern int ac97_read_proc (char *page_out, char **start, off_t off,

