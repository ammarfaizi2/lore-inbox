Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750820AbWCaQhq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820AbWCaQhq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 11:37:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751395AbWCaQhq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 11:37:46 -0500
Received: from cantor.suse.de ([195.135.220.2]:47594 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751380AbWCaQhn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 11:37:43 -0500
From: Andi Kleen <ak@suse.de>
To: Hans Boehm <Hans.Boehm@hp.com>
Subject: Re: Synchronizing Bit operations V2
Date: Fri, 31 Mar 2006 18:37:33 +0200
User-Agent: KMail/1.9.1
Cc: Christoph Lameter <clameter@sgi.com>,
       Zoltan Menyhart <Zoltan.Menyhart@bull.net>,
       "Grundler, Grant G" <grant.grundler@hp.com>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
References: <Pine.LNX.4.64.0603301300430.1014@schroedinger.engr.sgi.com> <p73vetu921a.fsf@verdi.suse.de> <Pine.GHP.4.58.0603310808190.28478@tomil.hpl.hp.com>
In-Reply-To: <Pine.GHP.4.58.0603310808190.28478@tomil.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603311837.34477.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 31 March 2006 18:22, Hans Boehm wrote:

> My impression is that approach (1) tends not to stick, since it involves
> a substantial performance hit on architectures on which the fence is
> not implicitly included in atomic operations.  Those include Itanium and
> PowerPC.

At least the PPC people are eating the overhead because back when they
didn't they had a long string of subtle powerpc only bugs caused by that

It's a stability/maintainability vs performance issue. I doubt the 
performance advantage would be worth the additional work. I guess
with the engineering time you would need to spend getting all this right
you could do much more fruitful optimizations.

-Andi
