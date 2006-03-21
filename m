Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030338AbWCUFqx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030338AbWCUFqx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 00:46:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030340AbWCUFqx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 00:46:53 -0500
Received: from mx1.redhat.com ([66.187.233.31]:37815 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030338AbWCUFqw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 00:46:52 -0500
Date: Tue, 21 Mar 2006 00:46:34 -0500
From: Dave Jones <davej@redhat.com>
To: tiwai@suse.de
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: unresolved emu10k1 synth symbols.
Message-ID: <20060321054634.GA5122@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, tiwai@suse.de,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just noticed this whilst booting 2.6.16 on a test box

snd_emu10k1_synth: Unknown symbol snd_emu10k1_ptr_read
snd_emu10k1_synth: Unknown symbol snd_emu10k1_synth_copy_from_user
snd_emu10k1_synth: Unknown symbol snd_emu10k1_voice_free
snd_emu10k1_synth: Unknown symbol snd_emu10k1_synth_free
snd_emu10k1_synth: Unknown symbol snd_emu10k1_ptr_write
snd_emu10k1_synth: Unknown symbol snd_emu10k1_synth_bzero
snd_emu10k1_synth: Unknown symbol snd_emu10k1_voice_alloc
snd_emu10k1_synth: Unknown symbol snd_emu10k1_memblk_map
snd_emu10k1_synth: Unknown symbol snd_emu10k1_synth_alloc

This kernel was configured with CONFIG_SND_EMU10K1=m
and CONFIG_SND_SEQUENCER=m

This looks like it can't possibly work, unless I change
CONFIG_SND_EMU10K1 to =y.  Is exporting a symbol from one
module to another actually supposed to work?
I thought this was why we had the ill-fated intermodule_register() ?.

		Dave

-- 
http://www.codemonkey.org.uk
