Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932393AbWGRUqF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932393AbWGRUqF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 16:46:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932395AbWGRUqF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 16:46:05 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:35812
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932393AbWGRUqE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 16:46:04 -0400
Date: Tue, 18 Jul 2006 13:46:25 -0700 (PDT)
Message-Id: <20060718.134625.123974562.davem@davemloft.net>
To: zach@vmware.com
Cc: arjan@infradead.org, chrisw@sous-sol.org, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       jeremy@goop.org, ak@suse.de, akpm@osdl.org, rusty@rustcorp.com.au,
       ian.pratt@xensource.com, Christian.Limpach@cl.cam.ac.uk
Subject: Re: [RFC PATCH 18/33] Subarch support for CPUID instruction
From: David Miller <davem@davemloft.net>
In-Reply-To: <44BCC720.7050601@vmware.com>
References: <20060718091953.003336000@sous-sol.org>
	<1153217686.3038.37.camel@laptopd505.fenrus.org>
	<44BCC720.7050601@vmware.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zachary Amsden <zach@vmware.com>
Date: Tue, 18 Jul 2006 04:33:52 -0700

> You really need a CPUID hook.  The instruction is non-virtualizable, and 
> anything claiming to be a hypervisor really has to support masking and 
> flattening the cpuid namespace for the instruction itself.  It is used 
> in assembler code and very early in boot.  The alternative is injecting 
> a bunch of Xen-specific code to filter feature bits into the i386 layer, 
> which is both bad for Linux and bad for Xen - and was quite ugly in the 
> last set of Xen patches.

Userspace will still see the full set of cpuid bits, since
it can still execute cpuid unimpeded, is this ok?
