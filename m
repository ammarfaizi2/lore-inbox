Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262356AbUFWVpX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262356AbUFWVpX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 17:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263126AbUFWVpV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 17:45:21 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:38528 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266180AbUFWVmQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 17:42:16 -0400
Message-ID: <40D9F925.2000304@pobox.com>
Date: Wed, 23 Jun 2004 17:41:57 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Robert Picco <Robert.Picco@hp.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HPET driver
References: <200406181616.i5IGGECd003812@hera.kernel.org>	<40D35740.8070206@pobox.com> <20040618145531.015fbc12.akpm@osdl.org> <40D37090.20909@pobox.com> <40D9F74A.9090508@hp.com>
In-Reply-To: <40D9F74A.9090508@hp.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Picco wrote:
> Hi Andrew:
> 
> I eliminated the request_irq brain damage, eliminated procfs support, 
> made the check for FMODE_WRITE  in hpet_open and responded to a few 
> other suggestions.

Thanks!  I'll look over it too.


> I misinterpreted your desire to change HPET from using a major device 
> number and moving to miscdevice.  I thought one objective was to avoid 
> LANANA registration.  It obviously isn't and I have done LANANA 
> registration but need a reply.  So it's possible the values for hpet in 
> miscdevice.h and devices.txt will change.

The LANANA stuff propagates to 2.4 and to vendors who update their /dev 
packages.  You can't just pick an arbitrary number and use it.  If 
LANANA hasn't replied, the driver should use dynamic miscdev minor, or 
dynamic chrdev major, until a number is assigned.

	Jeff



