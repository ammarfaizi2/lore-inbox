Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932435AbVKWUgf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932435AbVKWUgf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 15:36:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932535AbVKWUgd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 15:36:33 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:4480 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932435AbVKWUgH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 15:36:07 -0500
Subject: Re: PROBLEM: No initialization of sound card
From: Lee Revell <rlrevell@joe-job.com>
To: Pelle =?ISO-8859-1?Q?Lundstr=F6m?= <lunper@gmail.com>
Cc: David Wragg <david@wragg.org>, linux-kernel@vger.kernel.org,
       ALSA user list <alsa-user@lists.sourceforge.net>
In-Reply-To: <b1952ae90511231230j1121e7a0v501cf135761e154a@mail.gmail.com>
References: <m3veyxo8jb.fsf@dwragg.oilspace.com>
	 <1131841275.15223.17.camel@mindpipe>
	 <b1952ae90511231230j1121e7a0v501cf135761e154a@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Date: Wed, 23 Nov 2005 15:34:42 -0500
Message-Id: <1132778083.10453.24.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-23 at 21:30 +0100, Pelle Lundström wrote:
> When running the commands "lsmod | grep ^snd | cut -d\  -f1 | xargs
> rmmod" and then "modprobe snd_es18xx" then I get errors.
> 
> The dmesg output is:
> : Unknown symbol snd_info_register

This usually means your ALSA modules were not compiled against the right
kernel version.  Or some of the old modules failed to unload and you're
now trying to load a mix of old and new modules.

Lee

