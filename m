Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261703AbVASMZf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261703AbVASMZf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 07:25:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261707AbVASMZe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 07:25:34 -0500
Received: from one.firstfloor.org ([213.235.205.2]:20938 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S261703AbVASMZ3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 07:25:29 -0500
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: <fastboot@lists.osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 19/29] x86_64-kexec
References: <overview-11061198973484@ebiederm.dsl.xmission.com>
	<x86-rename-apic-mode-exint-11061198973109@ebiederm.dsl.xmission.com>
	<x86-local-apic-fix-11061198972413@ebiederm.dsl.xmission.com>
	<x86-64-e820-64bit-11061198971581@ebiederm.dsl.xmission.com>
	<x86-i8259-shutdown-11061198973856@ebiederm.dsl.xmission.com>
	<x86-64-i8259-shutdown-11061198973969@ebiederm.dsl.xmission.com>
	<x86-apic-virtwire-on-shutdown-11061198973730@ebiederm.dsl.xmission.com>
	<x86-64-apic-virtwire-on-shutdown-11061198973345@ebiederm.dsl.xmission.com>
	<vmlinux-fix-physical-addrs-11061198973860@ebiederm.dsl.xmission.com>
	<x86-vmlinux-fix-physical-addrs-11061198971192@ebiederm.dsl.xmission.com>
	<x86-64-vmlinux-fix-physical-addrs-11061198972723@ebiederm.dsl.xmission.com>
	<x86-64-entry64-1106119897218@ebiederm.dsl.xmission.com>
	<x86-config-kernel-start-1106119897152@ebiederm.dsl.xmission.com>
	<x86-64-co <x86-64-kexec-11061198973999@ebiederm.dsl.xmission.com>
From: Andi Kleen <ak@muc.de>
Date: Wed, 19 Jan 2005 13:25:28 +0100
In-Reply-To: <x86-64-kexec-11061198973999@ebiederm.dsl.xmission.com> (Eric
 W. Biederman's message of "Wed, 19 Jan 2005 0:31:37 -0700")
Message-ID: <m13bwx4nd3.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric W. Biederman" <ebiederm@xmission.com> writes:

[note an extensive review of all this code, but from a quick read...]

> +
> +static void load_segments(void)
> +{
> +	__asm__ __volatile__ (
> +		"\tmovl $"STR(__KERNEL_DS)",%eax\n"
> +		"\tmovl %eax,%ds\n"
> +		"\tmovl %eax,%es\n"
> +		"\tmovl %eax,%ss\n"
> +		"\tmovl %eax,%fs\n"
> +		"\tmovl %eax,%gs\n"
> +		);

This misses an clobber for "eax" 


-Andi
