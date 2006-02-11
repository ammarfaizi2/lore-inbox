Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964783AbWBKToN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964783AbWBKToN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 14:44:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964784AbWBKToM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 14:44:12 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:22659 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S964783AbWBKToM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 14:44:12 -0500
Subject: Re: [Alsa-devel] Re: ALSA - pnp OS bios option
From: Lee Revell <rlrevell@joe-job.com>
To: Nick Warne <nick@linicks.net>
Cc: Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>,
       linux-kernel@vger.kernel.org, alsa-devel@lists.sourceforge.net
In-Reply-To: <200602111054.50947.nick@linicks.net>
References: <200601092022.56244.nick@linicks.net>
	 <200601101759.20707.nick@linicks.net> <s5hek3geyup.wl%tiwai@suse.de>
	 <200602111054.50947.nick@linicks.net>
Content-Type: text/plain
Date: Sat, 11 Feb 2006 14:44:06 -0500
Message-Id: <1139687047.19342.91.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.90 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-02-11 at 10:54 +0000, Nick Warne wrote:
> Sorting SB Live! sound (alsactl restore)...
> alsactl: set_control:894: warning: name mismatch (Sigmatel Surround
> Playback 
> Volume/Sigmatel Surround Playback Switch) for control #47
> alsactl: set_control:896: warning: index mismatch (0/0) for control
> #47
> alsactl: set_control:1008: bad control.47.value index
> 
> 

Harmless

> Ummm.  At the command line, same errors also.  So I
> deleted /etc/asound.state 
> and reconfigured alsamixer from scratch.  Then following 'alsactl
> store', 
> 'alsactl restore' completes without issue (i.e. works clean).
> 
> If I then reboot, the same damn control #47 errors happen again.  It's
> as if 
> something changes my asound.state file at boot time time?
> 

Probably you have two different alsactl's installed, one that's
hardcoded to save the state in /etc/asound.state, and a distro version
that wants to save it in /var/lib/whatever.  It sounds like one is being
run at boot and a different one at shutdown.

