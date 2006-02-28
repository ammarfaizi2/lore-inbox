Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932296AbWB1RwJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932296AbWB1RwJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 12:52:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932298AbWB1RwI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 12:52:08 -0500
Received: from mx.pathscale.com ([64.160.42.68]:60627 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932296AbWB1RwH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 12:52:07 -0500
Subject: Re: [PATCH] Define wc_wmb, a write barrier for PCI write combining
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200602280944.32210.jbarnes@virtuousgeek.org>
References: <1140841250.2587.33.camel@localhost.localdomain>
	 <200602251428.01767.ak@suse.de>
	 <1140894083.9852.30.camel@localhost.localdomain>
	 <200602280944.32210.jbarnes@virtuousgeek.org>
Content-Type: text/plain
Date: Tue, 28 Feb 2006 09:52:06 -0800
Message-Id: <1141149126.24103.11.camel@camp4.serpentine.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-02-28 at 09:44 -0800, Jesse Barnes wrote:

> Something like this would be really handy.  Check out fbmem.c:fb_mmap for 
> a bad example of what can happen w/o it.

:-)

> In fact, I think it might make sense to export WC functionality via an 
> mmap flag (on an advisory basis since the platform may not support it or 
> there may be aliasing issues that prevent it); having an arch 
> independent routine to request it would make that addition easy to do in 
> generic code.

Yes.

>   (In particular I wanted this for the sysfs PCI interface.  
> Userspace apps can map PCI resources there and it would be nice if they 
> could map them with WC semantics if requested.)

They already sort of can.  It just happens that most arches ignore the
WC parameters.

> I don't think it addresses the flushing issue you seem to be concerned 
> about though.

Yes, I think I could have made my original wording a bit clearer.  I
don't care if writes have hit the device, merely that they do so in an
order that I control.

	<b

