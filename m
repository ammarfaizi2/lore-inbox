Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261826AbVAYGAX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261826AbVAYGAX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 01:00:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261827AbVAYGAW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 01:00:22 -0500
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:4496 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S261826AbVAYGAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 01:00:19 -0500
Date: Mon, 24 Jan 2005 21:59:01 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Terence Ripperda <tripperda@nvidia.com>
Cc: Keith Owens <kaos@ocs.com.au>, davidm@hpl.hp.com, bgerst@didntduck.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: inter_module_get and __symbol_get
Message-ID: <20050125055901.GA14453@taniwha.stupidest.org>
References: <16885.30810.787188.591830@napali.hpl.hp.com> <30494.1106606658@ocs3.ocs.com.au> <20050125053104.GF1716@hygelac>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050125053104.GF1716@hygelac>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2005 at 11:31:04PM -0600, Terence Ripperda wrote:

> this is probably a stupid question, but how are weak references
> used?

the linker sets them to zero, so "if (foo) { ... }" works nicely

it does mean if a module that set foo to non-zero is loaded, we need
to zero it again when it's unloaded or else we have stale bogus
pointers left around
