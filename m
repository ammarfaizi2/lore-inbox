Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272157AbTG2XF6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 19:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272163AbTG2XF5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 19:05:57 -0400
Received: from mgr6.xmission.com ([198.60.22.206]:15508 "EHLO
	mgr6.xmission.com") by vger.kernel.org with ESMTP id S272157AbTG2XFV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 19:05:21 -0400
Date: Tue, 29 Jul 2003 17:04:50 -0600
From: "S. Anderson" <sa@xmission.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, "S. Anderson" <sa@xmission.com>,
       pavel@xal.co.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       adaplas@pol.net
Subject: Re: OOPS 2.6.0-test2, modprobe i810fb
Message-ID: <20030729170450.A27489@xmission.xmission.com>
References: <20030728171806.GA1860@xal.co.uk> <20030728201954.A16103@xmission.xmission.com> <20030728202600.18338fa9.akpm@osdl.org> <20030728231812.A20738@xmission.xmission.com> <20030728225914.4f299586.akpm@osdl.org> <20030729012417.A18449@xmission.xmission.com> <20030729005456.495c89c4.akpm@osdl.org> <1059479872.2921.7.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1059479872.2921.7.camel@dhcp22.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Tue, Jul 29, 2003 at 01:00:40PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 29, 2003 at 01:00:40PM +0100, Alan Cox wrote:
> On Maw, 2003-07-29 at 08:54, Andrew Morton wrote:
> > wtf?  So the memory at d094ee7c (which contains i810fb's pci table) became
> > unmapped from kernel virtual address space as a result of you inserting
> > your carbus card.
> > 
> > I am impressed.
> 
> This makes complete sense actually - its marked __initdata. Remove the
> __initdata and try again or mark it __devinitdata ?
> 

Just to confirm your findings:
Changing __initdata to __devinitdata fixes the oops for me.

Thanks!
sa
