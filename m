Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264605AbTFHGOM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jun 2003 02:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264606AbTFHGOM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jun 2003 02:14:12 -0400
Received: from ns.suse.de ([213.95.15.193]:37394 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264605AbTFHGOL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jun 2003 02:14:11 -0400
To: "Bryan O'Sullivan" <bos@serpentine.com>
Subject: Re: memtest86 on the opteron
Cc: error27@email.com, chris@memtest86.com, linux-kernel@vger.kernel.org
References: <20030607202725.22992.qmail@email.com.suse.lists.linux.kernel>
	<20030607214356.GF667@elf.ucw.cz.suse.lists.linux.kernel>
	<1055040745.27939.3.camel@camp4.serpentine.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 08 Jun 2003 08:27:46 +0200
In-Reply-To: <1055040745.27939.3.camel@camp4.serpentine.com.suse.lists.linux.kernel>
Message-ID: <p73of195bj1.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bryan O'Sullivan <bos@serpentine.com> writes:

> On Sat, 2003-06-07 at 14:43, Pavel Machek wrote:
> 
> > Well, as opteron is i386-compatible, you should be able to simply use
> > i386 memtest...
> 
> It doesn't work.  Crashes and reboots the system shortly after it
> starts.  The serial console support appears to have bit-rotted, too, so
> I've not been able to capture an output screen to diagnose the problem.

The problem is the CPUID handling in memtest86. It does not expect
the 15 model number on AMD systems. Someone did a patch for it, but
I don't remember where they put it. Anyways should be easy to fix again
given the source.

-Andi
