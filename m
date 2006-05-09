Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751468AbWEIIc4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751468AbWEIIc4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 04:32:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751478AbWEIIc4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 04:32:56 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:40197 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1751468AbWEIIcz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 04:32:55 -0400
Message-ID: <44605396.40507@shadowen.org>
Date: Tue, 09 May 2006 09:32:22 +0100
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michael Ellerman <michael@ellerman.id.au>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       haveblue@us.ibm.com, kravetz@us.ibm.com
Subject: Re: [PATCH] SPARSEMEM + NUMA can't handle unaligned memory regions?
References: <20060509070343.57853679F2@ozlabs.org>
In-Reply-To: <20060509070343.57853679F2@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Ellerman wrote:
> I can't believe I'm the first person to see this, so I imagine I'm missing
> something. Perhaps it's only an issue on powerpc?
> 
> I have a machine with some memory at 0, then a hole, and then some more memory
> which doesn't start on a section boundary. This is causing the following
> crash:
> 
> add_region nid 1 start_pfn 0x77c0 pages 0x840
> add_region nid 1 start_pfn 0x0 pages 0x6000

Nasty, could you send me your full boot log and your config and I'll
have a look at it.  I can say this code has been booted on a lot of
power boxes and I've never seen that before!  :)

Anyhow, will take a look and see if we can avoid iterating over the area
to find it.

-apw
