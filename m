Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264184AbUDBVdK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 16:33:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264178AbUDBVdJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 16:33:09 -0500
Received: from gprs214-45.eurotel.cz ([160.218.214.45]:7296 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S264184AbUDBVcL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 16:32:11 -0500
Date: Fri, 2 Apr 2004 22:57:23 +0200
From: Pavel Machek <pavel@suse.cz>
To: Takashi Iwai <tiwai@suse.de>
Cc: Rajsekar <rajsekar@peacock.iitm.ernet.in>, linux-kernel@vger.kernel.org
Subject: Re: alsamixer muting when restoring from suspend.
Message-ID: <20040402205723.GJ195@elf.ucw.cz>
References: <y49y8phn2op.fsf@sahana.cs.iitm.ernet.in> <s5hk710vy8x.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hk710vy8x.wl@alsa2.suse.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > This I think is not a problem but rather a subtle bug.
> > 
> > Alsamixer by default mutes all channels when loaded.
> > So when I `swsusp' my comp while I listen to music and restore the music
> > plays from where it left alright, but the channels are muted.
> > Is there a way to unmute them implicitly when restoring.
> 
> which driver?
> not all drivers have suspend/resume callbacks.

Could it be solved at higher layer, perhaps? Setting volume is common
to all drivers, and some kind of generic_alsa_suspend every alsa
driver would call might help...
							Pavel
PS: I know very little about alsa.

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
