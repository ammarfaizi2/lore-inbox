Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751150AbVKJQsP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbVKJQsP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 11:48:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751149AbVKJQsP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 11:48:15 -0500
Received: from student.if.pw.edu.pl ([194.29.174.5]:9179 "EHLO
	tleilax.if.pw.edu.pl") by vger.kernel.org with ESMTP
	id S1751150AbVKJQsO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 11:48:14 -0500
Date: Thu, 10 Nov 2005 17:48:04 +0100 (CET)
From: Marek Szuba <cyberman@if.pw.edu.pl>
To: linux-kernel@vger.kernel.org
Subject: ALSA in 2.6.14: RTC timer breaks MIDI
Message-ID: <Pine.LNX.4.62.0511101735350.30579@gyrvynk.vs.cj.rqh.cy>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(I'm having problems with access to the ALSA bug tracker, that's why I'm 
reporting this issue here)

Hello everyone,

A couple of days ago I tried to play a MIDI file on a 2.6.14 box with 
emu10k1 for sound (Audigy 2 ZS) and was surprised to hear that the 
sequencer no longer works - or to be exact, when having it play any MIDI 
song it only starts playing the first note in each channel and leaves them 
like that, playing the same tones until the player's closed. Going back to 
2.6.13 made the problem go away; on the other hand, even an upgrade of 
ALSA userspace components to the latest version doesn't help with 2.6.14.

Having investigated a bit, I found out the problem lies with the 
newly-added "Use RTC as default sequence timer" option; turning it off and 
recompiling the kernel lets MIDI be played as before.

By the way, shouldn't snd-rtctimer be automatically pulled in if the 
aforementioned option is set and MIDI drivers are loaded? I have noticed 
the only way to make it actually be used by other ALSA modules is to have 
it manually loaded before all the others, as it doesn't get loaded on its 
own and loading it after the others doesn't cause it to be used, at least 
not automatically. Of course regardless of whether and how this module is 
loaded doesn't affect the fact that as long as the aforementioned option 
is set, MIDI remains useless; recompilation is the only way.

PS. In case it is not clear, in the setup in question all ALSA components 
are built as modules.

Let me know if you need more information.

Regards,
-- 
MS
