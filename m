Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262037AbUK3KW5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262037AbUK3KW5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 05:22:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262038AbUK3KW5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 05:22:57 -0500
Received: from gprs214-203.eurotel.cz ([160.218.214.203]:46976 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262037AbUK3KWy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 05:22:54 -0500
Date: Tue, 30 Nov 2004 11:22:21 +0100
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: kd6pag@qsl.net, linux-kernel@vger.kernel.org, perex@suse.cz
Subject: Re: 2.6.10-rc2 on VAIO laptop and PowerMac 8500/G3
Message-ID: <20041130102221.GB1057@elf.ucw.cz>
References: <E1CVYZM-0000Fi-00@penngrove.fdns.net> <20041120185100.GA1205@elf.ucw.cz> <20041129163533.14afa2a5.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041129163533.14afa2a5.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > The software suspend issue was long and tedious to narrow down.  Yep, as
> > > you suspected, it appears to be specific a driver (or group thereof).  It
> > > appears to happen when the sound subsystem is included.  Attached below 
> > > is the .config and a 'diff' from the losing one to one which works.
> > 
> > Okay, this is for the alsa team then. Somewhere between 2.6.10-rc1 and
> > 2.6.10-rc2, ALSA started breaking swsusp :-(.
> 
> What does "breaking" mean?  The driver fails to suspend the device? 
> Scribbles on memory?

Usually driver hangs during resume or shortly after that. Things like
"failed to initialize hardware and driver not robust enough to deal
with hardware being gone". I've not yet seen scribbling over memory
(and hopefully it stays that way :-).

Oh btw those alsa problems were fixed, IIRC: I think it was "not
restoring PCI config space correctly".
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
