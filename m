Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263654AbUCUOMf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 09:12:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263652AbUCUOMf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 09:12:35 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:8429 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S263655AbUCUOMe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 09:12:34 -0500
Message-ID: <405DA2C9.9090707@colorfullife.com>
Date: Sun, 21 Mar 2004 15:12:25 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.4.1) Gecko/20031114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjanv@redhat.com>
CC: Eli Cohen <mlxk@mellanox.co.il>, linux-kernel@vger.kernel.org
Subject: Re: locking user space memory in kernel
References: <405D7D2F.9050507@colorfullife.com>
In-Reply-To: <405D7D2F.9050507@colorfullife.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan wrote:

>On Sun, 2004-03-21 at 12:18, Eli Cohen wrote:
>> Hi,
>> I need to be able to lock memory allocated in user space and passed to 
>> my driver, in order to pass it to a dma controller that can maintain a 
>> translation table for each process. The obvious thing is to use 
>
>the linux way is to do it the other way around, provide a device that
>userspace then can mmap......
>
That's definitively the preferred method, but unfortunately there are 
existing apis that are the other way around. I think the main MPI 
transfer functions must read/write to arbitrary addresses, I'm sure 
there are other examples.

--
    Manfred

