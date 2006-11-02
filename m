Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751974AbWKBQcI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751974AbWKBQcI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 11:32:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751981AbWKBQcI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 11:32:08 -0500
Received: from iriserv.iradimed.com ([69.44.168.233]:65302 "EHLO iradimed.com")
	by vger.kernel.org with ESMTP id S1751973AbWKBQcF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 11:32:05 -0500
Message-ID: <454A1D82.7040709@cfl.rr.com>
Date: Thu, 02 Nov 2006 11:32:02 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: Jun Sun <jsun@junsun.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Can Linux live without DMA zone?
References: <20061102021547.GA1240@srv.junsun.net>
In-Reply-To: <20061102021547.GA1240@srv.junsun.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Nov 2006 16:32:06.0550 (UTC) FILETIME=[6F7DB360:01C6FE9C]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.6.1039-14788.003
X-TM-AS-Result: No--18.079000-5.000000-4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shouldn't only ancient ISA drivers be using GFP_DMA?  You know, ones 
that actually require it?  PCI drivers should not have this limit.

Jun Sun wrote:
> I am trying to reserve a block of memory (>16MB) starting from 0 and hide it 
> from kernel.  A consequence is that DMA zone now has size 0.  That causes
> many drivers to grief (OOMs).
> 
> I see two ways out:
> 
> 1. Modify individual drivers and convince them not to alloc with GFP_DMA.
>    I have been trying to do this but do not seem to see an end of it.  :)
> 
> 2. Simply lie and increase MAX_DMA_ADDRESS to really big (like 1GB) so that
>    the whole memory region belongs to DMA zone.
> 
> #2 sounds pretty hackish.  I am sure something bad will happen
> sooner or later (like what?). But so far it appears to be working fine.
> 
> The fundamental question is: Has anybody tried to run Linux without 0 sized
> DMA zone before?  Am I doing something that nobody has done before (which is
> something really hard to believe these days with Linux :P)?
> 
> Cheers.
> 
> Jun

