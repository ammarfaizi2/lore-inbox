Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262176AbTJFOz7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 10:55:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262182AbTJFOz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 10:55:59 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:10635 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S262176AbTJFOz6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 10:55:58 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16257.33403.756457.433093@gargle.gargle.HOWL>
Date: Mon, 6 Oct 2003 16:55:55 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Otavio Salvador <otavio@debian.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test6-bk7: kernel freeze if try to change to console
In-Reply-To: <87vfr2ttev.fsf@retteb.casa>
References: <87d6db2gw0.fsf@retteb.casa>
	<16257.17952.546250.954616@gargle.gargle.HOWL>
	<87vfr2ttev.fsf@retteb.casa>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Otavio Salvador writes:
 > Mikael Pettersson <mikpe@csd.uu.se> writes:
 > 
 > > Otavio Salvador writes:
 > >  > Folks,
 > >  > 
 > >  > I'm using kernel 2.6.0-test6-bk7 and have some problems. If I try to
 > >  > change to console from X my system freeze. I'm including my .config
 > >  > file bellow.
 > >
 > > I have a hunch but I need to see your boot dmesg log to confirm.
 > > Please post it.
 > 
 > Hello,
 > 
 > Here is it.

Ok now I'm confused. The .config you posted earlier stated that
you had both UP_APIC and APM_DISPLAY_BLANK enabled. Your dmesg
log indicates that you're running on a 1.6GHz Athlon-XP, but
there's no mention of APIC anything in the dmesg log.

So either your Athlon has had its local APIC disabled, or you
changed the .config to exclude UP_APIC.

In any case, APM_DISPLAY_BLANK is known to sometimes lock up when it
blanks the console (e.g., when X exists). This is because some graphics
card BIOSen can't handle local APIC interrupts (e.g., the timer).
The workaround is to disable either APM_DISPLAY_BLANK or UP_APIC.

/Mikael
