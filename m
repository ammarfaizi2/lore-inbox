Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132843AbRDXHVn>; Tue, 24 Apr 2001 03:21:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132844AbRDXHVd>; Tue, 24 Apr 2001 03:21:33 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:60774 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S132843AbRDXHVR>; Tue, 24 Apr 2001 03:21:17 -0400
To: "Manfred Spraul" <manfred@colorfullife.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Longstanding elf fix (2.4.3 fix)
In-Reply-To: <004201c0cc40$07c79ef0$5517fea9@local>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 24 Apr 2001 01:19:28 -0600
In-Reply-To: "Manfred Spraul"'s message of "Mon, 23 Apr 2001 23:54:22 +0200"
Message-ID: <m1zod6rchr.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Manfred Spraul" <manfred@colorfullife.com> writes:

> > Well looking a little more closely than I did last night it looks like
> > access_process_vm (called from ptrace) can cause what amounts to a
> > page fault at pretty arbitrary times.
> 
> It's also used for several /proc/<pid> files.
> 
> I remember that I got crashes with concurrent exec+cat
> /proc/<pid>/cmdline until down(mmap_sem) was added into
> setup_arg_pages().

O.k. Then the race I'm catching is real though because it is confined
to bss sections, we are quite unlikely to trigger it.

Eric
