Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266512AbUGPOnT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266512AbUGPOnT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 10:43:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266516AbUGPOnT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 10:43:19 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:22141 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S266512AbUGPOnR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 10:43:17 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: [PATCH] reduce inter-node balancing frequency
Date: Fri, 16 Jul 2004 10:42:39 -0400
User-Agent: KMail/1.6.2
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       John Hawkes <hawkes@sgi.com>
References: <200407151829.20069.jbarnes@engr.sgi.com> <200407152158.17605.jbarnes@engr.sgi.com> <2700000.1089956404@[10.10.2.4]>
In-Reply-To: <2700000.1089956404@[10.10.2.4]>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407161042.39748.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, July 16, 2004 1:40 am, Martin J. Bligh wrote:
> Arch code. Arch code. Arch code ;-) Or at least base it of nr_cpus or
> numnodes. Seriously ... a 2x or 4x opteron obviously needs different
> parameters from a 16x x440 or a 512x SGI box ... why we have a flexible
> infrastructure that can stand on its head and do backflips, and then
> we don't use it at all is a mystery to me ;-)
>
> I'd even go so far as to suggest there should be NO default settings for
> NUMA, only in arch code - that'd make people actually think about it.
> If there are, they should be based off the topo infrastructure, not static
> values.

Yep, no arguments here.  I agree about not having default NUMA settings too, 
having them only in arch code would be best.  At least until we have a few 
NUMA architectures using this stuff, then we can refactor out the common code 
if it makes sense later.

Jesse
