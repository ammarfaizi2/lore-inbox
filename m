Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262539AbUCCS27 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 13:28:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262540AbUCCS26
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 13:28:58 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:10646 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262539AbUCCS25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 13:28:57 -0500
To: "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [CFT][PATCH] 2.6.4-rc1 remove x86 boot page tables
References: <D36CE1FCEFD3524B81CA12C6FE5BCAB002FFE999@fmsmsx406.fm.intel.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 03 Mar 2004 01:15:47 -0700
In-Reply-To: <D36CE1FCEFD3524B81CA12C6FE5BCAB002FFE999@fmsmsx406.fm.intel.com>
Message-ID: <m14qt64a8c.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Tolentino, Matthew E" <matthew.e.tolentino@intel.com> writes:

> > I have rewritten and compiled tested the boot_ioremap code but I don't
> > have a configuration to test it. This effects the EFI code and the
> > numa srat code.   It might be worth replacing boot_ioremap with __va()
> > to reduce the amount of error checking necessary.
> 
> I just blindly applied this patch and tried it on an x86 EFI system
> with no luck.  It's not mapping correctly for some reason.  I'll look
> at the problem closer in a bit.

Stupid question.  What is efi doing in arch/i386 anyway?

All of the to be production efi x86 systems I have heard of support
x86-64.  So shouldn't it be 64bit calls that we need to worry about?


Eric
