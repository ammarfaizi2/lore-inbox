Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261752AbUCPWWz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 17:22:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261756AbUCPWWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 17:22:55 -0500
Received: from colino.net ([62.212.100.143]:14334 "EHLO paperstreet.colino.net")
	by vger.kernel.org with ESMTP id S261752AbUCPWWy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 17:22:54 -0500
Date: Tue, 16 Mar 2004 23:22:14 +0100
From: Colin Leroy <colin@colino.net>
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.5-rc1: snd-powermac missing symbol
Message-Id: <20040316232214.5f0c174b@jack.colino.net>
Organization: 
X-Mailer: Sylpheed version 0.9.8claws (GTK+ 2.2.4; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

$ sudo modprobe snd-powermac
Password:
FATAL: Error inserting snd_powermac (/lib/modules/2.6.5-rc1/kernel/sound/ppc/snd-powermac.ko): Unknown symbol in module, or unknown parameter (see dmesg)
$ dmesg
adt746x: Setting speed to: 128 for CPU fan.
snd_powermac: Unknown symbol snd_pcm_dma_flags

Solved by adding 
#define snd_pcm_dma_flags(x) ((void *)(unsigned long)(x))
but I doubt it's the correct way...
-- 
Colin
