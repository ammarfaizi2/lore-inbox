Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267275AbTGKUat (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 16:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267325AbTGKUas
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 16:30:48 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:35729 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S267275AbTGKUah (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 16:30:37 -0400
Date: Fri, 11 Jul 2003 22:45:06 +0200
From: Pavel Machek <pavel@suse.cz>
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org, acpi-support@lists.sourceforge.net
Subject: Re: [2.5.75] S3 and S4
Message-ID: <20030711204506.GA169@elf.ucw.cz>
References: <20030711193611.GA824@dreamland.darkstar.lan> <20030711200053.GA402@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030711200053.GA402@elf.ucw.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Fixing swap signatures... <3>bad: scheduling while atomic!
> > Call Trace:
> >  [<c012419e>] schedule+0x6ce/0x6e0
> >  [<c02a219d>] generic_make_request+0x17d/0x210
> >  [<c01272d0>] autoremove_wake_function+0x0/0x50
> >  [<c012641e>] io_schedule+0xe/0x20
> >  [<c0150522>] wait_on_page_bit+0xa2/0xd0
> >  [<c01272d0>] autoremove_wake_function+0x0/0x50
> >  [<c01272d0>] autoremove_wake_function+0x0/0x50
> >  [<c017194b>] swap_readpage+0x5b/0x80
> >  [<c0171a2a>] rw_swap_page_sync+0xba/0x110
> >  [<c014d8be>] mark_swapfiles+0x7e/0x1b0
> >  [<c014ea35>] do_magic_resume_2+0xe5/0x170
> >  [<c011d410>] restore_processor_state+0x70/0x90
> >  [<c011ff5f>] do_magic+0x11f/0x140
> >  [<c014ef1d>] do_software_suspend+0x6d/0xa0
> >  [<c023e3cc>] acpi_system_write_sleep+0x11b/0x132
> >  [<c0177de0>] filp_open+0x60/0x70
> >  [<c017952d>] vfs_write+0xad/0x120
> >  [<c017963f>] sys_write+0x3f/0x60
> >  [<c010b10f>] syscall_call+0x7/0xb
> 
> Ahha, this looks like generic problem. I'll probably take a look...

It is not generic -- I can't reproduce it here. Perhaps its side
effect of your e100 problems? You have to debug...
								Pavel

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
