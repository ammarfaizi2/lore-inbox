Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262027AbULHFgy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262027AbULHFgy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 00:36:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262033AbULHFgy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 00:36:54 -0500
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:61105
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262027AbULHFgx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 00:36:53 -0500
Date: Tue, 7 Dec 2004 21:35:01 -0800
From: "David S. Miller" <davem@davemloft.net>
To: "Zou, Nanhai" <nanhai.zou@intel.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, tony.luck@intel.com,
       ak@suse.de, ralf@linux-mips.org, paulus@au.ibm.com,
       schwidefsky@de.ibm.com, Davem@davemloft.net
Subject: Re: [Compatibilty patch] sigtimedwait
Message-Id: <20041207213501.1103c8b7.davem@davemloft.net>
In-Reply-To: <894E37DECA393E4D9374E0ACBBE7427013C9FB@pdsmsx402.ccr.corp.intel.com>
References: <894E37DECA393E4D9374E0ACBBE7427013C9FB@pdsmsx402.ccr.corp.intel.com>
X-Mailer: Sylpheed version 1.0.0beta3 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Dec 2004 08:48:56 +0800
"Zou, Nanhai" <nanhai.zou@intel.com> wrote:

> This patch also merges all 6 32 bit layer sys_rt_sigtimedwait in IA64,
> X86_64, PPC64, Sparc64, S390 and MIPS into 1 compat_rt_sigtimedwait.
> 
> I have only tested it on X86_64 and IA64.
> It looks a bit weird for 
> #ifdef  __MIPSEL__ in generic code. 
> But I don't have any better idea for this.

The sparc64 part looks fine.

Instead of __MIPSEL__ you should be checking endianness
with the generic __BIG_ENDIAN and __LITTLE_ENDIAN
macros.
