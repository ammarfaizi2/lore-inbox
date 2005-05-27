Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262610AbVE0WGr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262610AbVE0WGr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 18:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262611AbVE0WGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 18:06:46 -0400
Received: from fire.osdl.org ([65.172.181.4]:55447 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262610AbVE0WGi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 18:06:38 -0400
Date: Fri, 27 May 2005 15:07:25 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: build failure; CONFIG_HZ* unset if power management is not
 selected (2.6.12-rc5-mm1)
Message-Id: <20050527150725.5065f3b8.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.62.0505280000020.2370@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.62.0505280000020.2370@dragon.hyggekrogen.localhost>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl <juhl-lkml@dif.dk> wrote:
>
> The randomly generated 
> config didn't set CONFIG_PM

--- 25/arch/i386/Kconfig~i386-selectable-frequency-of-the-timer-interrupt-fix	2005-05-26 04:18:51.000000000 -0700
+++ 25-akpm/arch/i386/Kconfig	2005-05-26 04:18:51.000000000 -0700
@@ -960,6 +960,8 @@ config SECCOMP
 
 	  If unsure, say Y. Only embedded should say N here.
 
+source kernel/Kconfig.hz
+
 endmenu
 
 
@@ -1116,8 +1118,6 @@ config APM_REAL_MODE_POWER_OFF
 	  a work-around for a number of buggy BIOSes. Switch this option on if
 	  your computer crashes instead of powering off properly.
 
-source kernel/Kconfig.hz
-
 endmenu
 
 source "arch/i386/kernel/cpu/cpufreq/Kconfig"
_

