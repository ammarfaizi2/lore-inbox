Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261644AbUKITr5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261644AbUKITr5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 14:47:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261643AbUKITq1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 14:46:27 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:11514 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261652AbUKITpE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 14:45:04 -0500
Subject: Re: Externalize SLIT table
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: Andi Kleen <ak@suse.de>
Cc: Erich Focht <efocht@hpce.nec.com>, Jack Steiner <steiner@sgi.com>,
       Takayoshi Kochi <t-kochi@bq.jp.nec.com>, linux-ia64@vger.kernel.org,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20041104170435.GA19687@wotan.suse.de>
References: <20041103205655.GA5084@sgi.com>
	 <20041104.105908.18574694.t-kochi@bq.jp.nec.com>
	 <20041104141337.GA18445@sgi.com> <200411041631.42627.efocht@hpce.nec.com>
	 <20041104170435.GA19687@wotan.suse.de>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1100029500.3980.15.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 09 Nov 2004 11:45:00 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-11-04 at 09:04, Andi Kleen wrote:
> On Thu, Nov 04, 2004 at 04:31:42PM +0100, Erich Focht wrote:
> > On Thursday 04 November 2004 15:13, Jack Steiner wrote:
> > > I think it would also be useful to have a similar cpu-to-cpu distance
> > > metric:
> > > ????????% cat /sys/devices/system/cpu/cpu0/distance
> > > ????????10 20 40 60 
> > > 
> > > This gives the same information but is cpu-centric rather than
> > > node centric.
> > 
> > I don't see the use of that once you have some way to find the logical
> > CPU to node number mapping. The "node distances" are meant to be
> 
> I think he wants it just to have a more convenient interface,
> which is not necessarily a bad thing.  But then one could put the 
> convenience into libnuma anyways.
> 
> -Andi

Using libnuma sounds fine to me.  On a 512 CPU system, with 4 CPUs/node,
we'd have 128 nodes.  Re-exporting ALL the same data, those huge strings
of node-to-node distances, 512 *additional* times in the per-CPU sysfs
directories seems like a waste.

-Matt

