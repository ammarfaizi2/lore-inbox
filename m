Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263163AbTDRRHA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 13:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263176AbTDRRGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 13:06:47 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:25749 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263163AbTDRRGn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 13:06:43 -0400
Message-ID: <3EA03363.5060807@pobox.com>
Date: Fri, 18 Apr 2003 13:18:27 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Don Cohen <don-linux@isis.cs3-inc.com>
CC: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org
Subject: Re: proposed optimization for network drivers
References: <200304170656.h3H6ujA28940@isis.cs3-inc.com>	<20030418.013640.28803567.davem@redhat.com> <16032.7069.454420.811252@isis.cs3-inc.com>
In-Reply-To: <16032.7069.454420.811252@isis.cs3-inc.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don Cohen wrote:
> In part I agree.  I would have preferred to make my change in one
> place instead of one driver at a time.  On the other hand, it seems to
> me that some of these details are already spread around all the
> drivers.  For instance, why does every driver have to call
> eth_type_trans?  Could that be delayed for netif_rx ?
> 
> I do think it's reasonable for a driver to test whether the upper
> layers are ready to process another packet.  I suggest that this 
> test be encapsulated into a new function that can be changed at the
> cost of only recompiling all the drivers.


Why not NAPI?  That is the existing mechanism provided to let the upper 
layer feedback to the low-level driver system congestion information.

	Jeff



