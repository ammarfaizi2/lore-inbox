Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271418AbTGQLFM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 07:05:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271422AbTGQLFM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 07:05:12 -0400
Received: from ookhoi.xs4all.nl ([213.84.114.66]:37340 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S271418AbTGQLFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 07:05:03 -0400
Date: Thu, 17 Jul 2003 13:19:58 +0200
From: Ookhoi <ookhoi@humilis.net>
To: Takashi Iwai <tiwai@suse.de>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>, eugene.teo@eugeneteo.net
Subject: Re: 2.6 sound drivers?
Message-ID: <20030717111958.GB30717@favonius>
Reply-To: ookhoi@humilis.net
References: <20030716225826.GP2412@rdlg.net> <20030716231029.GG1821@matchmail.com> <20030716233045.GR2412@rdlg.net> <1058426808.1164.1518.camel@workshop.saharacpt.lan> <20030717085704.GA1381@eugeneteo.net> <s5hu19lzevt.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hu19lzevt.wl@alsa2.suse.de>
X-Uptime: 13:09:31 up 38 days, 49 min, 30 users,  load average: 1.00, 1.00, 1.00
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takashi Iwai wrote (ao):
> At Thu, 17 Jul 2003 16:57:04 +0800,
> Eugene Teo wrote:
> > One thing I noticed abt this ALSA driver is that if I am playing
> > say, xmms at the moment, any additional sound output will be delayed
> > until I stop xmms. Is there any workaround? 
> > 
> > Using Intel(r) AC'97 Audio Controller - Sigmatel 9723 Codec
> 
> the intel chip supports only one stream for playback, so the
> succeeding open is blocked since ALSA opens the device in the blocking
> mode as default.  and it's so for OSS-emulation, too.
> 
> for the oss-emulation, you can change this behavior via the module
> option nonblock_open of snd-pcm-oss module.  please check
> Documentation/sound/alsa/OSS-Emulation.txt.

Wouldn't esd (the enlightment sound daemon) take care of this in
userspace? I can have sound out of xmms, firebird, mpg321 and mplayer at
the same time with esd.
