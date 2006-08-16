Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750779AbWHPQgE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750779AbWHPQgE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 12:36:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbWHPQgE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 12:36:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:17794 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750779AbWHPQgB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 12:36:01 -0400
Date: Wed, 16 Aug 2006 18:35:57 +0200
From: Andi Kleen <ak@suse.de>
To: Len Brown <lenb@kernel.org>
Cc: Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH for review] [54/145] x86_64: Remove obsolete PIC mode
Message-Id: <20060816183557.f7ab6b69.ak@suse.de>
In-Reply-To: <200608161231.49856.len.brown@intel.com>
References: <20060810 935.775038000@suse.de>
	<20060810193609.2977113C0B@wotan.suse.de>
	<200608161231.49856.len.brown@intel.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Aug 2006 12:31:49 -0400
Len Brown <len.brown@intel.com> wrote:

> On Thursday 10 August 2006 15:36, Andi Kleen wrote:
> 
> 
> > PIC mode is an outdated way to drive the APICs that was used on 
> > some early MP boards. It is not supported in the ACPI model.
> > 
> > It is unlikely to be ever configured by any x86-64 system
> > 
> > Remove it thus.
> 
> Is there any reason we can't entirely remove MPS from x86_64?
> (asside from the routines that ACPI uses)

There are still people who like to compile with CONFIG_ACPI=n or use 
acpi=off

I wouldn't have a problem with disallowing CONFIG_ACPI=n, but acpi=off
still needs to work.

A lot of the newer systems don't have mptables anymore, but there are 
still a lot around who do.

-Andi

