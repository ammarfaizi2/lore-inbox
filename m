Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751983AbWAEGCi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751983AbWAEGCi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 01:02:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751987AbWAEGCi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 01:02:38 -0500
Received: from gate.crashing.org ([63.228.1.57]:38615 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751983AbWAEGCh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 01:02:37 -0500
Subject: Re: [PATCH] fix workqueue oops during cpu offline
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Nathan Lynch <ntl@pobox.com>, linux-kernel@vger.kernel.org,
       Ben Collins <bcollins@debian.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <200601051558.14275.ncunningham@cyclades.com>
References: <20060105045810.GE16729@localhost.localdomain>
	 <200601051558.14275.ncunningham@cyclades.com>
Content-Type: text/plain
Date: Thu, 05 Jan 2006 17:03:08 +1100
Message-Id: <1136440988.4840.60.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-05 at 15:58 +1000, Nigel Cunningham wrote:
> Hi.
> 
> On Thursday 05 January 2006 14:58, Nathan Lynch wrote:
> > With 2.6.15, powerpc systems oops when cpu 0 is offlined.  This is a
> > regression from 2.6.14, caused by commit id
> > bce61dd49d6ba7799be2de17c772e4c701558f14 ("Fix hardcoded cpu=0 in
> > workqueue for per_cpu_ptr() calls").
> 
> So it's valid on ppc for cpu 0 to be taken offline? IIRC, trying that on my P4 
> a while back did nothing. I think you'll find other places that assume that 
> cpu 0 is always up (swsusp? ... I should check suspend2).

It's bogus, cpu0 can be put offline.

Ben.


