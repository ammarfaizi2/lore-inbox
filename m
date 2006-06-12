Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752082AbWFLS2H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752082AbWFLS2H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 14:28:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752083AbWFLS2H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 14:28:07 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:35482 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1752082AbWFLS2G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 14:28:06 -0400
Date: Mon, 12 Jun 2006 11:27:44 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Andi Kleen <ak@suse.de>
cc: Ingo Molnar <mingo@elte.hu>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: broken local_t on i386
In-Reply-To: <200606121906.28692.ak@suse.de>
Message-ID: <Pine.LNX.4.64.0606121124510.19770@schroedinger.engr.sgi.com>
References: <20060609214024.2f7dd72c.akpm@osdl.org> <200606121848.05438.ak@suse.de>
 <Pine.LNX.4.64.0606120950280.19309@schroedinger.engr.sgi.com>
 <200606121906.28692.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jun 2006, Andi Kleen wrote:

> It does, but the per cpu data that everybody uses doesn't reside in the PDA
> because it wasn't possible to make this work with binutils
> 
> It would require a relocation relative to another symbol which isn't
> really supported.

I dont think you need a relocation relative to another symbol. Map the 
pda to a virtual adress range. That is then translated with a 
processor specific page table to various physical addresses.

> At some point I considered using runtime patching to work around
> this limitation, but it would be some work and relatively complex.

Well this would drastically decreased the overhead for PDA access and fix 
local.t
