Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263893AbUAZI2L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 03:28:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264392AbUAZI2L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 03:28:11 -0500
Received: from mail-01.iinet.net.au ([203.59.3.33]:53674 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S263893AbUAZI2K
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 03:28:10 -0500
Message-ID: <4014CF39.50209@cyberone.com.au>
Date: Mon, 26 Jan 2004 19:26:33 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>,
       "Martin J. Bligh" <mbligh@aracnet.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: New NUMA scheduler and hotplug CPU
References: <20040125235431.7BC192C0FF@lists.samba.org>
In-Reply-To: <20040125235431.7BC192C0FF@lists.samba.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Rusty Russell wrote:

>Hi Nick!
>
>	Looking at your new scheduler in -mm, it uses cpu_online_map
>alot in arch_init_sched_domains.  This means with hotplug CPU that it
>would need to be modified: certainly possible to do, but messy.
>
>	The other option is to use cpu_possible_map to create the full
>topology up front, and then it need never change.  AFAICT, no other
>changes are neccessary: you already check against moving tasks to
>offline cpus.
>
>Anyway, I was just porting the hotplug CPU patches over to -mm, and
>came across this, so I thought I'd ask.
>

Hi Rusty,
Yes I'd like to use the cpu_possible_map to create the full
topology straight up. Martin?


