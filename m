Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265806AbTAXVxe>; Fri, 24 Jan 2003 16:53:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265815AbTAXVxe>; Fri, 24 Jan 2003 16:53:34 -0500
Received: from web80304.mail.yahoo.com ([66.218.79.20]:52291 "HELO
	web80304.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S265806AbTAXVxd>; Fri, 24 Jan 2003 16:53:33 -0500
Message-ID: <20030124220241.30218.qmail@web80304.mail.yahoo.com>
Date: Fri, 24 Jan 2003 14:02:41 -0800 (PST)
From: Kevin Lawton <kevinlawton2001@yahoo.com>
Subject: Re: Simple patches for Linux as a guest OS in a plex86 VM (please consider)
To: David Lang <david.lang@digitalinsight.com>
Cc: Derek Fawcus <dfawcus@cisco.com>, Valdis.Kletnieks@vt.edu,
       Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0301241256200.10187-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- David Lang <david.lang@digitalinsight.com> wrote:
> it sounds like you are saying that with the plex86 you have two ways to
> load a client OS.
> 
> 1. 'normal', full isolation of VMs no modification of the client OS
> needed.
> 
> 2. 'nice VM'. modification of the client OS required, but with the
> exception of the kernel level commands being eliminated in the
> modification full VM isolation is still provided. Much better performance
> then case #1

No, there's always full isolation.  If a guest is run without
mods similar to the ones I submitted for Linux, the interrupt
behaviour will not work correctly for the guest.  Neither
the host nor other guests will be affected.  Nor do I care,
because this is not for running arbitrary guest OSes.

x86 does not have pure VMability.  So, rather than trying real
hard to get under the hood to make it VM'able with heavy software
techniques, just forget about running all guest OSes and
run ones that can work, like Linux.

If you look, you'll notice my patches do nothing except macroize
the pushf/popf instructions to un-break the handling of eflags.IF
inside PVI mode (since x86 breaks it).  This has nothing to do
with isolation of the guest OS.  Nothing to do with running Windows.
Nothing to do with anything except running Linux as a guest.

-Kevin

__________________________________________________
Do you Yahoo!?
New DSL Internet Access from SBC & Yahoo!
http://sbc.yahoo.com
