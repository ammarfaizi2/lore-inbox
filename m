Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317462AbSGJAw2>; Tue, 9 Jul 2002 20:52:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317463AbSGJAw1>; Tue, 9 Jul 2002 20:52:27 -0400
Received: from draco.netpower.no ([212.33.133.34]:50955 "EHLO
	draco.netpower.no") by vger.kernel.org with ESMTP
	id <S317462AbSGJAw1>; Tue, 9 Jul 2002 20:52:27 -0400
Date: Wed, 10 Jul 2002 02:53:22 +0200
From: Erlend Aasland <erlend-a@innova.no>
To: Jaroslav Kysela <perex@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] include/sound/info.h
Message-ID: <20020710025322.A23535@innova.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

snd_info_create_module_entry() is declared with only two arguments when CONFIG_PROC_FS is not defined.

This patch should make the kernel compile for people who want sound but not procfs.


Erlend Aasland

diff -urN linux-2.5.25/include/sound/info.h linux-2.5.25-dirty/include/sound/info.h
--- linux-2.5.25/include/sound/info.h	2002-07-06 01:42:18.000000000 +0200
+++ linux-2.5.25-dirty/include/sound/info.h	2002-07-10 01:56:29.000000000 +0200
@@ -151,7 +151,7 @@
 
 static inline int snd_info_get_line(snd_info_buffer_t * buffer, char *line, int len) { return 0; }
 static inline char *snd_info_get_str(char *dest, char *src, int len) { return NULL; }
-static inline snd_info_entry_t *snd_info_create_module_entry(struct module * module, const char *name) { return NULL; }
+static inline snd_info_entry_t *snd_info_create_module_entry(struct module * module, const char *name, snd_info_entry_t * parent) { return NULL; }
 static inline snd_info_entry_t *snd_info_create_card_entry(snd_card_t * card, const char *name) { return NULL; }
 static inline void snd_info_free_entry(snd_info_entry_t * entry) { ; }
 static inline snd_info_entry_t *snd_info_create_device(const char *name,
