Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751241AbWD3Xn0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241AbWD3Xn0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 19:43:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751240AbWD3Xn0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 19:43:26 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:57257 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1751238AbWD3XnZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 19:43:25 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <44554AFE.30804@s5r6.in-berlin.de>
Date: Mon, 01 May 2006 01:40:46 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: How to replace bus_to_virt()?
References: <4454CF35.7010803@s5r6.in-berlin.de> <1146412215.20760.10.camel@laptopd505.fenrus.org>
In-Reply-To: <1146412215.20760.10.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (-0.052) AWL,BAYES_40
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Sun, 2006-04-30 at 16:52 +0200, Stefan Richter wrote:
>>is there a *direct* future-proof replacement for bus_to_virt()?
>>
>>It appears there are already architectures which do not define a 
>>bus_to_virt() funtion or macro. If there isn't a direct replacement, is 
>>there at least a way to detect at compile time whether bus_to_virt() exists?
> 
> 
> I'd go one step further: given a world with iommu's, and multiple pci
> domains etc, how can you know there even IS such a translation possible
> (without first having set it up from the other direction)?

Well, we actually do set it up from the other direction. But in a way 
that does not work with IOMMUs...

AFAIU, the patch "dc395x: dynamically map scatter-gather for PIO" [1] by 
Guennadi Liakhovetski is dealing with the same issue. I am not yet clear 
whether I could adopt this method for sbp2.
[1] http://marc.theaimsgroup.com/?l=linux-scsi&t=114400790300004
-- 
Stefan Richter
-=====-=-==- -=-= ----=
http://arcgraph.de/sr/
