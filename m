Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261446AbVBABKT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261446AbVBABKT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 20:10:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261449AbVBABKT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 20:10:19 -0500
Received: from ozlabs.org ([203.10.76.45]:12481 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261446AbVBABJ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 20:09:58 -0500
Subject: Re: [RFC][PATCH 2.6.11-rc2] vmlinux: add SETUP_DESC() to describe
	__setup() options
From: Rusty Russell <rusty@rustcorp.com.au>
To: Matt Domsch <Matt_Domsch@dell.com>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050131235039.GD24164@lists.us.dell.com>
References: <20050131235039.GD24164@lists.us.dell.com>
Content-Type: text/plain
Date: Tue, 01 Feb 2005 12:10:02 +1100
Message-Id: <1107220202.15836.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-01-31 at 17:50 -0600, Matt Domsch wrote:
> __setup() options are traditionally documented in
> Documentation/kernel-parameters.txt.  However, it would be nice if
> they could be documented alongside the implementation, similar to
> MODULE_PARM_DESC() fields for modules, and if 'modinfo vmlinux' could
> report such.
> 
> Patch below adds a new macro, SETUP_DESC(), which can be used to
> document the use cases of __setup() options.  A usage example in
> kernel/audit.c is provided as well.

I don't want to encourage the proliferation of __setup, and prefer
module_parm() for new code.  __setup() is good for certain fundamentals,
but the namespace and parsing help given by module_parm() usually makes
it a better choice.

That said, I don't have a particular issue with this.
Rusty.
-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

