Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932107AbWEGJ2o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbWEGJ2o (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 05:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932108AbWEGJ2n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 05:28:43 -0400
Received: from mx1.suse.de ([195.135.220.2]:31617 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932107AbWEGJ2n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 05:28:43 -0400
To: "C K Kashyap" <ckkashyap@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Booting vmlinux with GRUB on x86
References: <844f6ea60605052202i224bf7cew9018afa7e6959e11@mail.gmail.com>
From: Andi Kleen <ak@suse.de>
Date: 07 May 2006 11:28:41 +0200
In-Reply-To: <844f6ea60605052202i224bf7cew9018afa7e6959e11@mail.gmail.com>
Message-ID: <p73slnm420m.fsf@bragg.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"C K Kashyap" <ckkashyap@gmail.com> writes:

> Looks like kernel 2.6 generates a kernel that can be loaded by GRUB by
> just adding the multiboot signature...However, it does'nt quite work!
> ... Has anyone tried it? Just want to do away with the overhead of
> bzImage etc!!

bzImage has some real mode code that gets information from the BIOS
and passes it to the vmlinux (see Documentation/i386/zero-page.txt)
grub would need to pass this information first before it could execute
vmlinux directly.

There are also some more complications on x86-64: vmlinux currently
assumes it starts in 32bit protected mode, not 64bit.

-Andi
