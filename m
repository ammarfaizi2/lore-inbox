Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290862AbSBLJSt>; Tue, 12 Feb 2002 04:18:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290852AbSBLJSh>; Tue, 12 Feb 2002 04:18:37 -0500
Received: from smtp1.vol.cz ([195.250.128.73]:62729 "EHLO smtp1.vol.cz")
	by vger.kernel.org with ESMTP id <S290851AbSBLJIR>;
	Tue, 12 Feb 2002 04:08:17 -0500
Date: Mon, 11 Feb 2002 23:09:37 +0100
From: Pavel Machek <pavel@suse.cz>
To: Jens Axboe <axboe@suse.de>, kernel list <linux-kernel@vger.kernel.org>
Subject: small IDE cleanup: void * should not be used unless neccessary
Message-ID: <20020211220937.GA121@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This is really easy, please apply. (It will allow me to kill few casts
in future).
								Pavel

--- linux/include/linux/ide.h	Mon Feb 11 21:15:04 2002
+++ linux-dm/include/linux/ide.h	Mon Feb 11 22:36:12 2002
@@ -529,7 +531,7 @@
 
 typedef struct hwif_s {
 	struct hwif_s	*next;		/* for linked-list in ide_hwgroup_t */
-	void		*hwgroup;	/* actually (ide_hwgroup_t *) */
+	struct hwgroup_s *hwgroup;	/* actually (ide_hwgroup_t *) */
 	ide_ioreg_t	io_ports[IDE_NR_PORTS];	/* task file registers */
 	hw_regs_t	hw;		/* Hardware info */
 	ide_drive_t	drives[MAX_DRIVES];	/* drive info */

-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
