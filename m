Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264798AbTFLHHJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 03:07:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264799AbTFLHHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 03:07:09 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:49800 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264798AbTFLHHF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 03:07:05 -0400
Date: Thu, 12 Jun 2003 12:57:07 +0530
From: Ravikiran G Thirumalai <kiran@in.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patchset] Fix mishandling of error/exit patchs in 2.5 --3/3 es1371
Message-ID: <20030612072705.GJ1146@llm08.in.ibm.com>
References: <20030612071330.GG1146@llm08.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030612071330.GG1146@llm08.in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- linux-2.5.70-bk/sound/oss/es1371.c	2003-06-11 20:56:33.000000000 +0530
+++ bklatest/sound/oss/es1371.c	2003-06-11 23:13:06.000000000 +0530
@@ -2853,13 +2853,13 @@
 	printk(KERN_INFO PFX "found es1371 rev %d at io %#lx irq %u joystick %#x\n",
 	       s->rev, s->io, s->irq, s->gameport.io);
 	/* register devices */
-	if ((res=(s->dev_audio = register_sound_dsp(&es1371_audio_fops,-1))<0))
+	if ((res=(s->dev_audio = register_sound_dsp(&es1371_audio_fops,-1)))<0)
 		goto err_dev1;
-	if ((res=(s->codec.dev_mixer = register_sound_mixer(&es1371_mixer_fops, -1)) < 0))
+	if ((res=(s->codec.dev_mixer = register_sound_mixer(&es1371_mixer_fops, -1))) < 0)
 		goto err_dev2;
-	if ((res=(s->dev_dac = register_sound_dsp(&es1371_dac_fops, -1)) < 0))
+	if ((res=(s->dev_dac = register_sound_dsp(&es1371_dac_fops, -1))) < 0)
 		goto err_dev3;
-	if ((res=(s->dev_midi = register_sound_midi(&es1371_midi_fops, -1))<0 ))
+	if ((res=(s->dev_midi = register_sound_midi(&es1371_midi_fops, -1)))<0 )
 		goto err_dev4;
 #ifdef ES1371_DEBUG
 	/* initialize the debug proc device */
