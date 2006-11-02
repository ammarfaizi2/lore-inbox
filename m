Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752637AbWKBV0R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752637AbWKBV0R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 16:26:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752628AbWKBV0R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 16:26:17 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:575 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S1752637AbWKBV0P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 16:26:15 -0500
Message-ID: <454A627C.1090104@cfl.rr.com>
Date: Thu, 02 Nov 2006 16:26:20 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Jun Sun <jsun@junsun.net>, linux-kernel@vger.kernel.org
Subject: Re: Can Linux live without DMA zone?
References: <20061102021547.GA1240@srv.junsun.net>  <454A1D82.7040709@cfl.rr.com>  <1162486642.14530.64.camel@laptopd505.fenrus.org>  <454A4237.90106@cfl.rr.com> <1162498205.14530.83.camel@laptopd505.fenrus.org>
In-Reply-To: <1162498205.14530.83.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Nov 2006 21:26:20.0886 (UTC) FILETIME=[8A4B9760:01C6FEC5]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.6.1039-14790.000
X-TM-AS-Result: No--8.512100-5.000000-31
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> that's for the 32 bit boundary. THe problem is that there are 31, 30, 28
> and 26 bit devices as well, and those are in more trouble, and will
> eventually fall back to GFP_DMA (inside the x86 PCI code; the driver
> just uses the pci dma allocation routines) if they can't get suitable
> memory otherwise....
> 
> It's all nice in theory. But then there is the reality that not all
> devices are nice pci device that implement the entire spec;)
> 

Right, but doesn't the bounce/allocation routine take as a parameter the 
limit that the device can handle?  If the device can handle 28 bit 
addresses, then the kernel should not limit it to only 24 bits.
