Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262431AbVA0DUp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262431AbVA0DUp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 22:20:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262479AbVA0DRT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 22:17:19 -0500
Received: from marshall-cpe-34-bgd.sbb.co.yu ([82.117.197.34]:45696 "EHLO
	82.117.197.34") by vger.kernel.org with ESMTP id S262462AbVA0DPP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 22:15:15 -0500
Date: Thu, 27 Jan 2005 04:16:14 +0100 (CET)
From: Sasa Stevanovic <mg94c18@alas.matf.bg.ac.yu>
To: linux-kernel@vger.kernel.org
Subject: Possible bug in keyboard.c (2.6.10)
Message-ID: <Pine.LNX.4.61.0501270318290.4545@82.117.197.34>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I had some problems with my laptop's onetouch keys and it eventually led me to 
keyboard.c file from 2.6.10 kernel (Vojtech Pavlik and others).  There may be 
a bug in the file, please read below.

Well, actually, when all omnibook/messages/setkeycodes/hotkeys/xev/showkey etc 
stuff is stripped off, what remains is that x86_keycodes array has only first 
240 members initialized, while remaining 16 are set to 0 due to [256]:

static unsigned short x86_keycodes[256] = { <only 240 here> };

(For my scenario, workaround was possible.)

I am not sure if this is a bug or not; it worked in 2.4.18 without workaround. 
Might be that someone wanted to prevent reading invalid memory.  There are 
many versions of the file/array definition found on the web, none of which has 
a comment about this.

Please also use my email address <mg94c18@alas.matf.bg.ac.yu> if you respond 
to this.  I am a member but not sure for how long (depends on number of 
messages/day).

Thanks,
Sasa
