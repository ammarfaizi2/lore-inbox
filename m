Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751120AbWC2HLN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120AbWC2HLN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 02:11:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbWC2HLN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 02:11:13 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:50816 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751111AbWC2HLM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 02:11:12 -0500
Date: Tue, 28 Mar 2006 23:11:06 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
cc: "'Nick Piggin'" <nickpiggin@yahoo.com.au>,
       Zoltan Menyhart <Zoltan.Menyhart@free.fr>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: RE: Fix unlock_buffer() to work the same way as bit_unlock()
In-Reply-To: <200603290645.k2T6jbg03728@unix-os.sc.intel.com>
Message-ID: <Pine.LNX.4.64.0603282308490.20328@schroedinger.engr.sgi.com>
References: <200603290645.k2T6jbg03728@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Mar 2006, Chen, Kenneth W wrote:

> Nick Piggin wrote on Tuesday, March 28, 2006 6:36 PM
> > Hmm, not sure. Maybe a few new bitops with _lock / _unlock postfixes?
> > For page lock and buffer lock we'd just need test_and_set_bit_lock,
> > clear_bit_unlock, smp_mb__after_clear_bit_unlock.
> > 
> > I don't know, _for_lock might be a better name. But it's getting long.
> 
> I think kernel needs all 4 variants:
> 
> clear_bit
> clear_bit_lock
> clear_bit_unlock
> clear_bit_fence
> 
> And the variant need to permutated on all other bit ops ...  I think it
> would be indeed a better API and be more explicit about the ordering.

How about clear_bit(why, bit, address) in order to keep 
the variants down? Get rid of the smp_mb__*_xxxx stuff.




