Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262089AbVAOBki@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262089AbVAOBki (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 20:40:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbVAOBkg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 20:40:36 -0500
Received: from [81.2.110.250] ([81.2.110.250]:50153 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262133AbVAOBjy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 20:39:54 -0500
Subject: Re: swapspace layout improvements advocacy
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: Tim Schmielau <tim@physik3.uni-rostock.de>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20050114225213.GA4841@ip68-4-98-123.oc.oc.cox.net>
References: <20050112123524.GA12843@lnx-holt.americas.sgi.com>
	 <Pine.LNX.4.44.0501121758180.2765-100000@localhost.localdomain>
	 <20050112105315.2ac21173.akpm@osdl.org>
	 <Pine.LNX.4.53.0501141433000.7044@gockel.physik3.uni-rostock.de>
	 <20050114225213.GA4841@ip68-4-98-123.oc.oc.cox.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105744748.9222.41.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 15 Jan 2005 00:33:30 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-01-14 at 22:52, Barry K. Nathan wrote:
> I haven't tried the patch in question (unless it's in any Fedora
> kernels), but I've noticed that the single biggest step to improve
> swapping performance in 2.6 is to use the CFQ scheduler, not the AS
> scheduler. (That's also why Red Hat/Fedora kernels use CFQ as the
> default scheduler.)

Definitely the case. There is a lot wrong with our swap logic looked at
from the point of view of modern IDE disks at least beyond that though.

We'd be much better IMHO to have log structured swap so we can swap out
fast (which is normally time critical to get crap on disk and us back
running). The log tidier would then merge groups of pages either by va
or by read reference if they paged in and back out again.

There's probably an MSC or maybe a PHD lurking for someone in this sort
of area 8)

