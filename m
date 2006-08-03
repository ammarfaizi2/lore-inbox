Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932254AbWHCEta@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932254AbWHCEta (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 00:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932260AbWHCEt3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 00:49:29 -0400
Received: from cantor2.suse.de ([195.135.220.15]:211 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932254AbWHCEt3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 00:49:29 -0400
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <clameter@sgi.com>
Subject: Re: [patch 2/8] Implement always-locked bit ops, for memory shared with an SMP hypervisor.
Date: Thu, 3 Aug 2006 06:47:14 +0200
User-Agent: KMail/1.9.3
Cc: virtualization@lists.osdl.org, Zachary Amsden <zach@vmware.com>,
       akpm@osdl.org, xen-devel@lists.xensource.com,
       Chris Wright <chrisw@sous-sol.org>, Ian Pratt <ian.pratt@xensource.com>,
       linux-kernel@vger.kernel.org
References: <20060803002510.634721860@xensource.com> <200608030555.34569.ak@suse.de> <Pine.LNX.4.64.0608022124111.26980@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0608022124111.26980@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608030647.14159.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 03 August 2006 06:25, Christoph Lameter wrote:
> On Thu, 3 Aug 2006, Andi Kleen wrote:
> 
> > On Thursday 03 August 2006 03:25, Christoph Lameter wrote:
> > 
> > > Good idea. This will also make it easier to support this special 
> > > functionality. And it will avoid use in contexts where these are
> > > not necessary.
> > 
> > I think it's a bad idea. We don't want lots of architecture ifdefs
> > in some Xen specific file
> 
> Thats not how it would be done. We would do this with
> architecture specific xen files and a default in asm-generic.

It's cleaner to just do it in the generic code.

I think for most architectures it is only a one liner anyways if 
done properly.

-Andi
 
