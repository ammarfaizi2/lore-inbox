Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030210AbWBACrp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030210AbWBACrp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 21:47:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030211AbWBACrp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 21:47:45 -0500
Received: from liaag1ac.mx.compuserve.com ([149.174.40.29]:20617 "EHLO
	liaag1ac.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1030210AbWBACro (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 21:47:44 -0500
Date: Tue, 31 Jan 2006 21:44:20 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: 2.6.16-rc1-mm4
To: Andrew Morton <akpm@osdl.org>
Cc: Gerd Hoffman <kraxel@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200601312146_MC3-1-B74E-D5C4@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20060129144533.128af741.akpm@osdl.org>

 $ perl scripts/reference_init.pl | grep smp_locks
 Error: ./arch/i386/kernel/alternative.o .smp_locks refers to 00000008 R_386_32          .init.text
 Error: ./arch/i386/kernel/apic.o .smp_locks refers to 00000000 R_386_32          .init.text
 Error: ./arch/i386/kernel/apic.o .smp_locks refers to 00000010 R_386_32          .init.text
 Error: ./arch/i386/kernel/apic.o .smp_locks refers to 00000014 R_386_32          .init.text
 Error: ./arch/i386/kernel/cpu/amd.o .smp_locks refers to 00000000 R_386_32          .init.text
 Error: ./arch/i386/kernel/cpu/amd.o .smp_locks refers to 00000004 R_386_32          .init.text
 Error: ./arch/i386/kernel/cpu/amd.o .smp_locks refers to 00000008 R_386_32          .init.text
 Error: ./arch/i386/kernel/cpu/amd.o .smp_locks refers to 0000000c R_386_32          .init.text
 Error: ./arch/i386/kernel/cpu/amd.o .smp_locks refers to 00000010 R_386_32          .init.text
 Error: ./arch/i386/kernel/cpu/amd.o .smp_locks refers to 00000014 R_386_32          .init.text
 Error: ./arch/i386/kernel/cpu/amd.o .smp_locks refers to 00000018 R_386_32          .init.text
 Error: ./arch/i386/kernel/cpu/centaur.o .smp_locks refers to 00000000 R_386_32          .init.text
 Error: ./arch/i386/kernel/cpu/centaur.o .smp_locks refers to 00000004 R_386_32          .init.text
 ...

Caused by x86_smp_alternatives.patch

Does this mean that the SMP lock-switching could write all over discarded
__init code?

-- 
Chuck

