Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932160AbWAFI0X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932160AbWAFI0X (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 03:26:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932225AbWAFI0X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 03:26:23 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:16064 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932160AbWAFI0W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 03:26:22 -0500
To: Yinghai Lu <yinghai.lu@amd.com>
Cc: vgoyal@in.ibm.com, Andi Kleen <ak@muc.de>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Morton Andrew Morton <akpm@osdl.org>,
       "discuss@x86-64.org" <discuss@x86-64.org>, linuxbios@openbios.org
Subject: Re: Inclusion of x86_64 memorize ioapic at bootup patch
References: <20060103044632.GA4969@in.ibm.com>
	<86802c440601051630i4d52aa2fj1a2990acf858cd63@mail.gmail.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 06 Jan 2006 01:24:31 -0700
In-Reply-To: <86802c440601051630i4d52aa2fj1a2990acf858cd63@mail.gmail.com> (Yinghai
 Lu's message of "Thu, 5 Jan 2006 16:30:05 -0800")
Message-ID: <m1sls14vcw.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yinghai Lu <yinghai.lu@amd.com> writes:

> the patch is good.
>
> I tried LinuxBIOS with kexec.
>
> without this patch: I need to disable acpi in kernel. otherwise the
> kernel with acpi support can boot the second kernel, but the second
> kernel will hang after
>
> time.c: Using 14.318180 MHz HPET timer.
> time.c: Detected 2197.663 MHz processor.
> Console: colour VGA+ 80x25
> Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
> Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
> Memory: 1009152k/1048576k available (2967k kernel code, 39036k reserved, 1186k )

Yes. This is the reason the patch was written.  Every bios that
implements acpi has this problem.

Eric
