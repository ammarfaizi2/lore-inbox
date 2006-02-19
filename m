Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932239AbWBSTaL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932239AbWBSTaL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 14:30:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932241AbWBSTaL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 14:30:11 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:20135 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932239AbWBSTaJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 14:30:09 -0500
Subject: Re: No sound from SB live!
From: Lee Revell <rlrevell@joe-job.com>
To: Nick Warne <nick@linicks.net>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, Pavel Machek <pavel@suse.cz>,
       tiwai@suse.de, ghrt@dial.kappa.ro, perex@suse.cz,
       kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <7c3341450602190318o1c60e9b5w@mail.gmail.com>
References: <20060218231419.GA3219@elf.ucw.cz>
	 <9a8748490602190304w43c32ae6m5b610f2ec9ad46f2@mail.gmail.com>
	 <7c3341450602190318o1c60e9b5w@mail.gmail.com>
Content-Type: text/plain
Date: Sun, 19 Feb 2006 14:29:54 -0500
Message-Id: <1140377394.2733.341.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.91 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-02-19 at 11:18 +0000, Nick Warne wrote:
> alsactl: set_control:888: warning: iface mismatch (3/2) for control
> #80
> alsactl: set_control:890: warning: device mismatch (0/0) for control
> #80
> alsactl: set_control:892: warning: subdevice mismatch (0/0) for
> control #80
> alsactl: set_control:894: warning: name mismatch (EMU10K1 PCM Send
> Routing/External Amplifier) for control #80
> alsactl: set_control:896: warning: index mismatch (0/0) for control
> #80
> alsactl: set_control:898: failed to obtain info for control #80
> (Identifier removed)
> 
> 
> And now the confusing bit.  If I run alsamixer but DO NOT DO ANYTHING,
> exit, then issue 'alsactl store', then 'alsactl restore' works again
> OK - until next reboot... 

Sounds like you have 2 different alsactls installed.  The ALSA default
one saves the mixer state in /etc/asound.state but lots of distros hack
it up to save the state somewhere under /var.

Use "alsactl -f" to force a restore of mixer state even if the mixer
controls have changed (distros should do this by default but don't).

Lee

