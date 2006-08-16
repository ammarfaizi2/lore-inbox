Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751169AbWHPXIh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169AbWHPXIh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 19:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751190AbWHPXIh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 19:08:37 -0400
Received: from palrel13.hp.com ([156.153.255.238]:27269 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S1751169AbWHPXIf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 19:08:35 -0400
Message-ID: <44E3A572.20600@hp.com>
Date: Wed, 16 Aug 2006 16:08:34 -0700
From: Rick Jones <rick.jones2@hp.com>
User-Agent: Mozilla/5.0 (X11; U; HP-UX 9000/785; en-US; rv:1.7.13) Gecko/20060601
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linas Vepstas <linas@austin.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>, David Miller <davem@davemloft.net>,
       jeff@garzik.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org, jklewis@us.ibm.com, Jens.Osterkamp@de.ibm.com,
       akpm@osdl.org
Subject: Re: [PATCH 1/2]: powerpc/cell spidernet bottom half
References: <44E34825.2020105@garzik.org> <44E38157.4070805@garzik.org>	<20060816.134640.115912460.davem@davemloft.net>	<200608162324.47235.arnd@arndb.de> <20060816225558.GM20551@austin.ibm.com>
In-Reply-To: <20060816225558.GM20551@austin.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linas Vepstas wrote:
> On Wed, Aug 16, 2006 at 11:24:46PM +0200, Arnd Bergmann wrote:
> 
>>it only
>>seems to be hard to make it go fast using any of them. 
> 
> 
> Last round of measurements seemed linear for packet sizes between
> 60 and 600 bytes, suggesting that the hardware can handle a 
> maximum of 120K descriptors/second, independent of packet size.
> I don't know why this is.

DMA overhead perhaps?  If it takes so many micro/nanoseconds to get a 
DMA going....  That used to be a reason the Tigon2 had such low PPS 
rates and issues with multiple buffer packets and a 1500 byte MTU - it 
had rather high DMA setup latency, and then if you put it into a system 
with highish DMA read/write latency... well that didn't make it any 
better :)

rick jones
