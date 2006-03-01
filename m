Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751853AbWCATtl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751853AbWCATtl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 14:49:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751869AbWCATtl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 14:49:41 -0500
Received: from cantor2.suse.de ([195.135.220.15]:52379 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751853AbWCATtk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 14:49:40 -0500
From: Andi Kleen <ak@suse.de>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Subject: Re: [PATCH] Define wc_wmb, a write barrier for PCI write combining
Date: Wed, 1 Mar 2006 20:49:32 +0100
User-Agent: KMail/1.9.1
Cc: Benjamin LaHaise <bcrl@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <1140841250.2587.33.camel@localhost.localdomain> <200603012027.55494.ak@suse.de> <1141242206.2899.109.camel@localhost.localdomain>
In-Reply-To: <1141242206.2899.109.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603012049.32670.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 01 March 2006 20:43, Bryan O'Sullivan wrote:

> > Implementing the fences in the way your're suggesting would be very costly
> > because it could make them potentially stall for thousands of cycles.
> 
> But it *doesn't*.  On existing CPUs and systems, today, the phantom
> worse-case semantics you are conjuring up simply do not exist.  If
> someone builds such an asinine system, the right approach is to handle
> it once it exists.

Normally we write code to the defined architecture.

Relying on undocumented side effects of instructions as you're trying
to do here is not very reliable and would likely cause breakage later.

Especially not for encoding it in the general Linux interface.

-Andi
