Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267256AbTGWIGb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 04:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271155AbTGWIG0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 04:06:26 -0400
Received: from web41609.mail.yahoo.com ([66.218.93.109]:52114 "HELO
	web41609.mail.yahoo.com") by vger.kernel.org with SMTP
	id S267256AbTGWIFl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 04:05:41 -0400
Message-ID: <20030723082046.42027.qmail@web41609.mail.yahoo.com>
Date: Wed, 23 Jul 2003 10:20:46 +0200 (CEST)
From: =?iso-8859-1?q?willy=20tarreau?= <wtarreau@yahoo.fr>
Subject: Re: announce: kmsgdump update for 2.5.75
To: "Randy.Dunlap" <rddunlap@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Cc: willy@meta-x.org
In-Reply-To: <20030718140309.623ff4c9.rddunlap@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy, all.

OK finally I tested 2.5.74, 2.5.75 and 2.6.0-test1 on a PIII/800. They
all allowed be to get to the interactive screen after Sysrq-D (eventhough
the keyboard was dead after that, as always on this crappy machine/bios).

I noticed that you had a #define KDEBUG which puts printk's at every
checkpoint. I wonder if it's not risky to do this within the last ones,
when the machine is nearly ready to reboot. I'm not sure if this could
work with serial consoles or frame buffer. Could you please retry with
#undef KDEBUG ?

BTW, I'm not certain that the current code is still totally compatible
with standard kernel reboot techniques. I've read through it rather
quickly and compare it to other functions such as machine_real_restart(),
etc... It may be possible that we have to stop/notify some subsystems
prior to this.

FYI, on this machine, I enabled ACPI and local APIC, but disabled preempt.
Unfortunately, I don't have enough time to recheck with different combinations
of these options.

Hoping this helps a bit...

Cheers,
Willy


___________________________________________________________
Do You Yahoo!? -- Une adresse @yahoo.fr gratuite et en français !
Yahoo! Mail : http://fr.mail.yahoo.com
