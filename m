Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261507AbVBHKNN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261507AbVBHKNN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 05:13:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261506AbVBHKNN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 05:13:13 -0500
Received: from smtp.polymtl.ca ([132.207.4.11]:9168 "EHLO smtp.polymtl.ca")
	by vger.kernel.org with ESMTP id S261505AbVBHKNB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 05:13:01 -0500
Message-ID: <1107857501.4208905d3f019@www.imp.polymtl.ca>
Date: Tue,  8 Feb 2005 11:11:41 +0100
From: Guillaume Thouvenin <guillaume.thouvenin@polymtl.ca>
To: Jay Lan <jlan@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, Christoph Lameter <clameter@sgi.com>,
       torvalds@osdl.org, linux-kernel@vger.kernel.org,
       guillaume.thouvenin@bull.net
Subject: Re: move-accounting-function-calls-out-of-critical-vm-code-paths.patch
References: <20050110184617.3ca8d414.akpm@osdl.org> <Pine.LNX.4.58.0502031319440.25268@schroedinger.engr.sgi.com> <20050203140904.7c67a144.akpm@osdl.org> <Pine.LNX.4.58.0502031436460.26183@schroedinger.engr.sgi.com> <20050203150551.4d88f210.akpm@osdl.org> <42077724.1060606@sgi.com>
In-Reply-To: <42077724.1060606@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.3
X-Originating-IP: 129.185.75.9
X-Poly-FromMTA: (c4.si.polymtl.ca [132.207.4.29]) at Tue,  8 Feb 2005 10:11:41 +0000
X-AntiVirus: checked by Vexira Milter 1.0.6; VAE 6.29.0.7; VDF 6.29.0.101
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Selon Jay Lan <jlan@sgi.com>:

> CSA is currently implemented as a loadable module. I think ELSA is the
> same, right? The use of the enhanced accounting data collection
> code is not in the kernel tree. That was why Andrew did not see usage of
> the accounting patches. Should i propose to include the CSA module in
> the kernel then, Andrew? :)

In fact there is a module in ELSA but it's just to keep a trace of the processes
hierarchy in order to do processes group management and process group
accounting in user space.

The process group management is done by a user space daemon and the process
group accounting is done by a user space application that computes information
provided by BSD-per process accounting and/or CSA accounting with information
provided by the user space daemon.

Thus currently there is a module that relays information about forks but I'm
working on a kobject_uevent solution to send the fork event (thanks to Andrew
for the suggestion).

Thus, I will be interesting to see CSA module in the kernel.

Regards,
Guillaume




