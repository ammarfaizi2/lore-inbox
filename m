Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262874AbTEMFPu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 01:15:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262883AbTEMFPu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 01:15:50 -0400
Received: from ns.suse.de ([213.95.15.193]:24593 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262874AbTEMFPs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 01:15:48 -0400
Date: Tue, 13 May 2003 07:28:33 +0200
From: Andi Kleen <ak@suse.de>
To: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, hch@infradead.org,
       greg@kroah.com, linux-security-module@wirex.com
Subject: Re: [PATCH] Early init for security modules
Message-ID: <20030513052832.GF10596@Wotan.suse.de>
References: <20030512200309.C20068@figure1.int.wirex.com> <20030512201518.X19432@figure1.int.wirex.com> <20030513050336.GA10596@Wotan.suse.de> <20030512222000.A21486@figure1.int.wirex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030512222000.A21486@figure1.int.wirex.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 12, 2003 at 10:20:00PM -0700, Chris Wright wrote:
> * Andi Kleen (ak@suse.de) wrote:
> > 
> > It would work for x86-64. But why can't you use core_initcall() or 
> > postcore_initcall() ? 
> 
> This is too late.  Those are just for order in do_initcalls() which is
> well after some kernel threads have been created and filesystems have been
> mounted, etc.  This patch allows statically linked modules to catch
> the creation of such kernel objects and give them all consistent labels.

I would give them a generic name then in case someone else needs that too, 
like "early_initcalls" 

May be useful for some architecture initialization for example.

-Andi
