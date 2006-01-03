Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932382AbWACOjQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932382AbWACOjQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 09:39:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932379AbWACOjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 09:39:15 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:8578 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932356AbWACOjO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 09:39:14 -0500
Date: Tue, 3 Jan 2006 15:38:09 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
cc: Andi Kleen <ak@suse.de>, Adrian Bunk <bunk@stusta.de>, perex@suse.cz,
       alsa-devel@alsa-project.org, James@superbug.demon.co.uk,
       sailer@ife.ee.ethz.ch, linux-sound@vger.kernel.org, zab@zabbo.net,
       kyle@parisc-linux.org, parisc-linux@lists.parisc-linux.org,
       jgarzik@pobox.com, Thorsten Knabe <linux@thorsten-knabe.de>,
       zwane@commfireservices.com, zaitcev@yahoo.com,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
In-Reply-To: <200601031347.19328.s0348365@sms.ed.ac.uk>
Message-ID: <Pine.LNX.4.61.0601031530240.436@yvahk01.tjqt.qr>
References: <20050726150837.GT3160@stusta.de> <p7364p1jvkx.fsf@verdi.suse.de>
 <200601031347.19328.s0348365@sms.ed.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>It strikes me that it's a bit of a chicken and egg problem. Vendors are still 
>releasing applications on Linux that support only OSS, partly due to 
>ignorance, but mostly because ALSA's OSS compatibility layer allows them to 
>lazily ignore the ALSA API and target all cards, old and new.
>
>Additionally, we can't get rid of OSS compatibility until pretty much all 
>hardware has an ALSA driver, and (inferred from your comment) we can't get 
>rid of OSS drivers until nothing supports OSS, because the whole of the ALSA 
>stuff is a bit larger...
>
By OSS compatibility, do you mean the OSS PCM emulation layer (/dev/dsp)? I
think that should be kept. That way, legacy apps keep working, especially
unmaintained binary-only things like Unreal Tournament 1.

The OSS emulation does not depend on the OSS tree (CONFIG_SOUND_PRIME), so I
cannot quite follow your second paragraph - we should not remove OSS compat.
anytime.


Jan Engelhardt
-- 
