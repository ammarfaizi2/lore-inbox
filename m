Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964895AbVKMAuB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964895AbVKMAuB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 19:50:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964901AbVKMAuB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 19:50:01 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:9923 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S964895AbVKMAuA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 19:50:00 -0500
Subject: Re: PROBLEM: No initialization of sound card
From: Lee Revell <rlrevell@joe-job.com>
To: David Wragg <david@wragg.org>
Cc: Pelle =?ISO-8859-1?Q?Lundstr=F6m?= <lunper@gmail.com>,
       linux-kernel@vger.kernel.org,
       ALSA user list <alsa-user@lists.sourceforge.net>
In-Reply-To: <m3veyxo8jb.fsf@dwragg.oilspace.com>
References: <m3veyxo8jb.fsf@dwragg.oilspace.com>
Content-Type: text/plain; charset=ISO-8859-1
Date: Sat, 12 Nov 2005 19:21:14 -0500
Message-Id: <1131841275.15223.17.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-11-12 at 21:34 +0000, David Wragg wrote:
> On Sat, 2005-11-12 at 21:43 +0100, Pelle Lundström wrote:
> > 1. Kernel 2.6.14.2 fails to locate and initiate sound card.
> 
> I have seen similar problems due to trailing spaces on option lines in
> /etc/modprobe.com.  These get interpreted by the kernel as zero-length
> options, causing similar "unknown parameter" errors. So check that
> file, and remove any suspicious spaces at the ends of lines.

Run "lsmod | grep ^snd | cut -d\  -f1 | xargs rmmod" then modprobe
snd_es18xx from the command line, then send the output of dmesg if it
does not work.

FYI, please cc: alsa-user at lists.sourceforge.net with any future ALSA
bug reports (alsa-devel if you have a patch).

Lee

