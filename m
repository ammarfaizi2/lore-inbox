Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262999AbUDARh6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 12:37:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262996AbUDARh6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 12:37:58 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:1250 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262999AbUDARh4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 12:37:56 -0500
Message-ID: <406C523F.8030300@austin.ibm.com>
Date: Thu, 01 Apr 2004 11:32:47 -0600
From: Olof Johansson <olof@austin.ibm.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040304)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Manfred Spraul <manfred@colorfullife.com>
CC: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       anton@samba.org
Subject: Re: Oops in get_boot_pages at reboot
References: <Pine.A41.4.44.0403312015050.29064-100000@forte.austin.ibm.com> <406C4D3F.4070600@colorfullife.com>
In-Reply-To: <406C4D3F.4070600@colorfullife.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul wrote:

> mem_init_done is ppc specific. Is there an equivalent to system_running 
> that is not set to 0 during reboot?

Doh, my bad. :(  I'm not able to spot any other suitable variable myself.

system_running is checked in call_usermodehelper(), so keeping it at 1 
across devices_shutdown() might cause problems(?).


-Olof

-- 
Olof Johansson                                        Office: 4F005/905
Linux on Power Development                            IBM Systems Group
Email: olof@austin.ibm.com                          Phone: 512-838-9858
All opinions are my own and not those of IBM
