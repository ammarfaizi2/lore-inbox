Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269981AbTG2ISp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 04:18:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271207AbTG2ISp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 04:18:45 -0400
Received: from mgr2.xmission.com ([198.60.22.202]:18542 "EHLO
	mgr2.xmission.com") by vger.kernel.org with ESMTP id S269981AbTG2ISo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 04:18:44 -0400
Date: Tue, 29 Jul 2003 02:18:37 -0600
From: "S. Anderson" <sa@xmission.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "S. Anderson" <sa@xmission.com>, pavel@xal.co.uk,
       linux-kernel@vger.kernel.org, adaplas@pol.net
Subject: Re: OOPS 2.6.0-test2, modprobe i810fb
Message-ID: <20030729021837.A2457@xmission.xmission.com>
References: <20030728171806.GA1860@xal.co.uk> <20030728201954.A16103@xmission.xmission.com> <20030728202600.18338fa9.akpm@osdl.org> <20030728231812.A20738@xmission.xmission.com> <20030728225914.4f299586.akpm@osdl.org> <20030729012417.A18449@xmission.xmission.com> <20030729005456.495c89c4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030729005456.495c89c4.akpm@osdl.org>; from akpm@osdl.org on Tue, Jul 29, 2003 at 12:54:56AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 29, 2003 at 12:54:56AM -0700, Andrew Morton wrote:
> "S. Anderson" <sa@xmission.com> wrote:
> >
> >  Jul 29 00:40:12 localhost kernel: pci_match_device: &ids->vendor = d094ee7c
> >  Jul 29 00:40:12 localhost kernel: Unable to handle kernel paging request at virtual address d094ee7c
> 
> wtf?  So the memory at d094ee7c (which contains i810fb's pci table) became
> unmapped from kernel virtual address space as a result of you inserting
> your carbus card.
> 
> I am impressed.
> 
> Jsut as a crazy test, could you delete /sbin/rmmod and see if it still
> happens?  Maybe something is removing the module at an embarrassing time or
> something.
> 

I moved /sbin/rmmod* out of my path and I still get the oop. :-)

I will try to hack something together to find out if inserting a carbus
card unmaps i810fb's pci table, or if something else is doing it.

thanks,
Shawn Anderson
