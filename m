Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262918AbUCWXWt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 18:22:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262919AbUCWXWt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 18:22:49 -0500
Received: from mx1.redhat.com ([66.187.233.31]:47783 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262918AbUCWXWo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 18:22:44 -0500
Date: Tue, 23 Mar 2004 18:22:25 -0500 (EST)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: mingo@devserv.devel.redhat.com
To: Kurt Garloff <garloff@suse.de>
cc: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Non-Exec stack patches
In-Reply-To: <20040323231256.GP4677@tpkurt.garloff.de>
Message-ID: <Pine.LNX.4.58.0403231820420.320@devserv.devel.redhat.com>
References: <20040323231256.GP4677@tpkurt.garloff.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 24 Mar 2004, Kurt Garloff wrote:

> find attached a patch to parse the elf binaries for a PT_GNU_STACK
> section to set the stack non-executable if possible.
> Most parts have been shamelessly stolen from Ingo Molnar's more
> ambitious stackshield
> http://people.redhat.com/mingo/exec-shield/exec-shield-2.6.4-C9
> 
> The toolchain has meainwhile support for marking the binaries with a
> PT_GNU_STACK section with ot without x bit as needed.
> 
> If no such section is found, we leave the stack to whatever the arch
> defaults to. If there is one, we explicitly disabled the VM_EXEC bit if
> no x bit is found, otherwise explicitly enable.
> 
> I believe this part should be merged into official mainstream kernels.
> Ingo, what do you think?

agreed, and the patch looks good to me.

	Ingo
