Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266713AbUFRSjS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266713AbUFRSjS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 14:39:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266712AbUFRSjR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 14:39:17 -0400
Received: from outmail1.freedom2surf.net ([194.106.33.237]:15767 "EHLO
	outmail.freedom2surf.net") by vger.kernel.org with ESMTP
	id S266676AbUFRSg0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 14:36:26 -0400
Date: Fri, 18 Jun 2004 19:35:44 +0100
From: Ian Molton <spyro@f2s.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com, tony@atomide.com,
       david-b@pacbell.net, jamey.hicks@hp.com, joshua@joshuawise.com
Subject: Re: DMA API issues
Message-Id: <20040618193544.48b88771.spyro@f2s.com>
In-Reply-To: <1087582845.1752.107.camel@mulgrave>
References: <1087582845.1752.107.camel@mulgrave>
Organization: The Dragon Roost
X-Mailer: Sylpheed version 0.9.12-gtk2-20040617 (GTK+ 2.4.1; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 Jun 2004 13:20:43 -0500
James Bottomley <James.Bottomley@SteelEye.com> wrote:

> 
> Erm, well this isn't unusual.  A lot of devices have on board memory
> to offload accesses to.  All the later Symbios SCSI chips for
> instance.  If you look at the drivers, you'll see they ioremap the
> region and then use it via the normal memory accessors.

Thats all well and good for devices which have their own drivers, but
thats not the case always.

the device I described is an OHCI controller, and in theory, it should
be able to use the OHCI driver in the kernel without any modification,
*as long as* the DMA API returns valid device and virtual addresses,
which, at present, it does not.

