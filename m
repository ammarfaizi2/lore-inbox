Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287408AbSACWLW>; Thu, 3 Jan 2002 17:11:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287407AbSACWLM>; Thu, 3 Jan 2002 17:11:12 -0500
Received: from colorfullife.com ([216.156.138.34]:33540 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S287394AbSACWLC>;
	Thu, 3 Jan 2002 17:11:02 -0500
Message-ID: <3C34D6FC.9090207@colorfullife.com>
Date: Thu, 03 Jan 2002 23:11:08 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Who uses hdx=bswap or hdx=swapdata?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is the hdx=bswap or hdx=swapdata option actually in use?
When is it needed?
The current implementation can cause data corruptions on SMP with PIO 
transfers:
It modifies the source buffer during disk writes, and these temporary
modifications (within the irq handler) are visible with mmap on SMP.

Is it possible to remove the option entirely, or should it be fixed?

--
    Manfred

