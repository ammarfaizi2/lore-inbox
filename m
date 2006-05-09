Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750826AbWEIS51@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750826AbWEIS51 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 14:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147AbWEIS51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 14:57:27 -0400
Received: from schihei.net ([81.169.184.117]:33550 "EHLO schihei.org")
	by vger.kernel.org with ESMTP id S1750826AbWEIS50 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 14:57:26 -0400
X-PGP-Universal: processed;
	by Achilles.local on Tue, 09 May 2006 20:57:22 +0200
In-Reply-To: <20060509164919.GC5063@mellanox.co.il>
References: <4450A196.2050901@de.ibm.com> <adaejz9o4vh.fsf@cisco.com> <445B4DA9.9040601@de.ibm.com> <adafyjomsrd.fsf@cisco.com> <44608C90.30909@de.ibm.com> <adalktbcgl1.fsf@cisco.com> <20060509164919.GC5063@mellanox.co.il>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <40FCD6B6-9135-43C1-8974-E9070475DB78@schihei.de>
Cc: Roland Dreier <rdreier@cisco.com>, linux-kernel@vger.kernel.org,
       openib-general@openib.org, linuxppc-dev@ozlabs.org,
       Christoph Raisch <RAISCH@de.ibm.com>,
       Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>, Marcus Eder <MEDER@de.ibm.com>
Content-Transfer-Encoding: 7bit
From: Heiko J Schick <info@schihei.de>
Subject: Re: [openib-general] Re: [PATCH 07/16] ehca: interrupt handling routines
Date: Tue, 9 May 2006 20:57:01 +0200
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
X-Mailer: Apple Mail (2.749.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.05.2006, at 18:49, Michael S. Tsirkin wrote:

>> The trivial way to do it would be to use the same idea as the current
>> ehca driver: just create a thread for receive CQ events and a thread
>> for send CQ events, and defer CQ polling into those two threads.
>
> For RX, isn't this basically what NAPI is doing?
> Only NAPI seems better, avoiding interrupts completely and avoiding  
> latency hit
> by only getting triggered on high load ...

Does NAPI schedules CQ callbacks to different CPUs or stays the callback
(handling of data, etc.) on the same CPU where the interrupt came in?

Regards,
	Heiko
