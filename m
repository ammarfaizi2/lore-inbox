Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270047AbTGPCG4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 22:06:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270065AbTGPCG4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 22:06:56 -0400
Received: from adsl-63-195-249-97.dsl.sndg02.pacbell.net ([63.195.249.97]:45701
	"HELO mhughes.dhs.org") by vger.kernel.org with SMTP
	id S270047AbTGPCGz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 22:06:55 -0400
Subject: 2.6.0-test1 hangs silently in under an hour
From: Matthew Hughes <mhughes@mhughes.dhs.org>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1057119402.23657.16.camel@mhughes.dhs.org>
References: <1057119402.23657.16.camel@mhughes.dhs.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-11) 
Date: 15 Jul 2003 19:56:05 -0700
Message-Id: <1058324165.27867.16.camel@mhughes.dhs.org>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got a desktop machine which is hanging regularly with 
recent 2.5 and now 2.6.0-test1 releases. It seems very solid 
running 2.4.20 ...

The machine functions as a normal desktop (email, X, web browser,
etc) and as an NFS server for music served to a machine attached to 
the stereo (so light but consistent disk and network activity).

The symptom is simply a totally hung system - no response to keyboard, 
mouse, network pings, ctrl-alt-del, or magic sysrq. There is no output
to /var/log/messages that survives a reboot. I've compiled the kernel
with all the kernel debugging options set to true with no difference in
behavior:
CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_STACKOVERFLOW=y
CONFIG_DEBUG_SLAB=y
CONFIG_DEBUG_IOVIRT=y
CONFIG_MAGIC_SYSRQ=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_PAGEALLOC=y
CONFIG_DEBUG_SPINLOCK_SLEEP=y
CONFIG_FRAME_POINTER=y
CONFIG_X86_EXTRA_IRQS=y
CONFIG_X86_FIND_SMP_CONFIG=y
CONFIG_X86_MPPARSE=y

Some general info - 
Distribution: Red Hat 8.0
Hardware Environment: Athlon XP1900
Software Environment: gcc 3.2
The motherboard is an Asus A7V266-E. 

I'd be happy to run test patches, change config options, etc if that
would help ... also, if there's anything else I should be doing to 
track this down before reporting, please let me know or point me 
to a document.

I'm not a subscriber to lkml, so please CC me on any replies.
						Thanks!
						Matt Hughes
					mhughes@mhughes.dhs.org

