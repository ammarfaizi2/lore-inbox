Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030748AbWJKBqV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030748AbWJKBqV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 21:46:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030746AbWJKBqU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 21:46:20 -0400
Received: from outbound-sin.frontbridge.com ([207.46.51.80]:33517 "EHLO
	outbound2-sin-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1030742AbWJKBqR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 21:46:17 -0400
X-BigFish: V
Message-ID: <452C4CE0.5010607@am.sony.com>
Date: Tue, 10 Oct 2006 18:46:08 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
User-Agent: Mozilla Thunderbird 1.0.8-1.1.fc4 (X11/20060501)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jschopp <jschopp@austin.ibm.com>
CC: Linas Vepstas <linas@austin.ibm.com>, akpm@osdl.org, jeff@garzik.org,
       Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org,
       James K Lewis <jklewis@us.ibm.com>, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 21/21]: powerpc/cell spidernet DMA coalescing
References: <20061010204946.GW4381@austin.ibm.com>	<20061010212324.GR4381@austin.ibm.com> <452C2AAA.5070001@austin.ibm.com>
In-Reply-To: <452C2AAA.5070001@austin.ibm.com>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Oct 2006 01:46:08.0836 (UTC) FILETIME=[05EFC040:01C6ECD7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jschopp wrote:
> Linas Vepstas wrote:
>> The current driver code performs 512 DMA mappns of a bunch of 
>> 32-byte structures. This is silly, as they are all in contiguous 
>> memory. Ths patch changes the code to DMA map the entie area
>> with just one call.
>> 
>> Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
>> Cc: James K Lewis <jklewis@us.ibm.com>
>> Cc: Arnd Bergmann <arnd@arndb.de>
> 
> The others look good, but this one complicates the code and doesn't have any benefit.  20 
> for 21 isn't bad.

Linas, 

Is the motivation for this change to improve performance by reducing the overhead
of the mapping calls?  If so, there may be some benefit for some systems.  Could
you please elaborate?

-Geoff

