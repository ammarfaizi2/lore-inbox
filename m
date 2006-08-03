Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932108AbWHCBZv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108AbWHCBZv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 21:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932124AbWHCBZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 21:25:51 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:54497 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932108AbWHCBZv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 21:25:51 -0400
Date: Wed, 2 Aug 2006 18:25:09 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Zachary Amsden <zach@vmware.com>
cc: Jeremy Fitzhardinge <jeremy@goop.org>,
       Jeremy Fitzhardinge <jeremy@xensource.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>,
       Chris Wright <chrisw@sous-sol.org>
Subject: Re: [patch 2/8] Implement always-locked bit ops, for memory shared
 with an SMP hypervisor.
In-Reply-To: <44D14ECC.3080600@vmware.com>
Message-ID: <Pine.LNX.4.64.0608021821350.26404@schroedinger.engr.sgi.com>
References: <20060803002510.634721860@xensource.com> <20060803002518.061401577@xensource.com>
 <Pine.LNX.4.64.0608021726540.25963@schroedinger.engr.sgi.com>
 <44D144EC.3000205@goop.org> <Pine.LNX.4.64.0608021805150.26314@schroedinger.engr.sgi.com>
 <44D14ECC.3080600@vmware.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Aug 2006, Zachary Amsden wrote:

> It needn't be all architectures yet - only architectures that want to compile
> Xen drivers are really affected.  Perhaps a better place for these locking
> primitives is in a Xen-specific driver header which defines appropriate
> primitives for the architectures required?  Last I remember, there were still
> some issues here where atomic partial word operations couldn't be supported on
> some architectures.

Good idea. This will also make it easier to support this special 
functionality. And it will avoid use in contexts where these are
not necessary.
