Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423388AbWBBIzP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423388AbWBBIzP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 03:55:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423391AbWBBIzP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 03:55:15 -0500
Received: from mx1.redhat.com ([66.187.233.31]:61897 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1423390AbWBBIzO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 03:55:14 -0500
Date: Thu, 2 Feb 2006 03:54:15 -0500
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Pekka J Enberg <penberg@cs.Helsinki.FI>, kevin@koconnor.net,
       linux-kernel@vger.kernel.org, jgarzik@pobox.com,
       manfred@colorfullife.com
Subject: Re: [PATCH] slab leak detector (Was: Size-128 slab leak)
Message-ID: <20060202085415.GA11831@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>,
	Pekka J Enberg <penberg@cs.Helsinki.FI>, kevin@koconnor.net,
	linux-kernel@vger.kernel.org, jgarzik@pobox.com,
	manfred@colorfullife.com
References: <Pine.LNX.4.58.0602021021240.32240@sbz-30.cs.Helsinki.FI> <20060202004415.28249549.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060202004415.28249549.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2006 at 12:44:15AM -0800, Andrew Morton wrote:
 > Pekka J Enberg <penberg@cs.Helsinki.FI> wrote:
 > >
 > >  Here's a version that uses dbg_userword() instead of overriding bufctls 
 > >  and adds a CONFIG_DEBUG_SLAB_LEAK config option. Upside is that this works 
 > >  with the slab verifier patch and is less invasive.
 > 
 > What is the slab verifier patch?

See the thread.. "Re: 2.6.16rc1-git4 slab corruption"
Pekka posted a rediffed variant of a patch Manfred came up with
a while back, which periodically scans slabs for corruption, which
in the past has caught some bugs where we scribbled in the redzones
of long-living slab objects, which weren't picked up by regular SLAB_DEBUG.

		Dave

