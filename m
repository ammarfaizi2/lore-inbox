Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262984AbUDARMU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 12:12:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262969AbUDARMU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 12:12:20 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:40118 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S262984AbUDARMO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 12:12:14 -0500
Message-ID: <406C4D3F.4070600@colorfullife.com>
Date: Thu, 01 Apr 2004 19:11:27 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.4.1) Gecko/20031114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Olof Johansson <olof@austin.ibm.com>
CC: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       anton@samba.org
Subject: Re: Oops in get_boot_pages at reboot
References: <Pine.A41.4.44.0403312015050.29064-100000@forte.austin.ibm.com>
In-Reply-To: <Pine.A41.4.44.0403312015050.29064-100000@forte.austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olof Johansson wrote:

>So __pollwait() calls __get_free_page(), system_running is 0 so
>get_boot_pages is called. Since get_boot_pages is labeled __init, badness
>happens.
>  
>
I didn't notice that the reboot code resets system_running to 0, sorry.

>How about checking against mem_init_done instead of system_running? It
>helps against the oops, but there might be some good reason not to do
>it.
>
mem_init_done is ppc specific. Is there an equivalent to system_running 
that is not set to 0 during reboot?

--
    Manfred

