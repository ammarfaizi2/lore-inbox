Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262427AbTD3UiB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 16:38:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262429AbTD3UiB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 16:38:01 -0400
Received: from codepoet.org ([166.70.99.138]:41192 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id S262427AbTD3UiA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 16:38:00 -0400
Date: Wed, 30 Apr 2003 14:50:22 -0600
From: Erik Andersen <andersen@codepoet.org>
To: David van Hoose <davidvh@cox.net>
Cc: Marc-Christian Petersen <m.c.p@wolk-project.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: ALSA and 2.4.x
Message-ID: <20030430205021.GA20614@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	David van Hoose <davidvh@cox.net>,
	Marc-Christian Petersen <m.c.p@wolk-project.de>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20030424212508.GI14661@codepoet.org> <200304251401.36430.m.c.p@wolk-project.de> <200304251410.31701.m.c.p@wolk-project.de> <20030430090242.GA15480@codepoet.org> <3EB02D0F.1080101@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EB02D0F.1080101@cox.net>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.19-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Apr 30, 2003 at 03:07:43PM -0500, David van Hoose wrote:
> I'm getting an unresolved in soundcore.o that is preventing me from 
> having sound.
> /lib/modules/2.4.21-rc1/kernel/sound/soundcore.o: unresolved symbol 
> devfs_remove
> /lib/modules/2.4.21-rc1/kernel/sound/soundcore.o: insmod 
> /lib/modules/2.4.21-rc1/kernel/sound/soundcore.o failed
> /lib/modules/2.4.21-rc1/kernel/sound/soundcore.o: insmod snd-card-0 failed
> 
> Can that be fixed?

It looks like this is simply a minor include file problem.
sound/sound_core.c needs 
    #include <sound/driver.h>
added to it which should hopefully make this problem go away.

> Also I have problems if I compile USB Audio and USB MIDI from the USB 
> section AND USB Audio and USB MIDI from the ALSA section. Compilation 
> fails in that situation. Might want to put the former patch up if this 
> stuff might take a while to fix.

This looked trivial enough to fix, I went ahead and
regenerated my patch with these changes,

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
