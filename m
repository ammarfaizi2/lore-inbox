Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbUBGXHW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 18:07:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261411AbUBGXHW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 18:07:22 -0500
Received: from smtp-send.myrealbox.com ([192.108.102.143]:19636 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S261262AbUBGXHU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 18:07:20 -0500
Message-ID: <40257081.50706@myrealbox.com>
Date: Sat, 07 Feb 2004 15:10:57 -0800
From: walt <wa1ter@myrealbox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7a) Gecko/20040131
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: viro@parcelfarce.linux.theplanet.co.uk
CC: linux-kernel@vger.kernel.org
Subject: Re: [2.6.1] Kernel panic with ppa driver updates
References: <4023D098.1000904@myrealbox.com> <20040206182844.GJ21151@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20040206182844.GJ21151@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

viro@parcelfarce.linux.theplanet.co.uk wrote:
> On Fri, Feb 06, 2004 at 09:36:24AM -0800, walt wrote:
> 
>>This panic started with the bk changesets applied by Linus yesterday.
>>
>>The ppa driver works fine when compiled as a module, but when compiled in
>>I get this during boot:
(panic message snipped)

> Could you post the actual oops?...

Whew!  I had to relearn everything I was happy to forget about
serial communications to get this!  I even stopped to repair a
broken RS-232 break-out box that I haven't used in years ;0)
I hope this helps:


ppa: Version 2.07 (for Linux 2.4.x)
Unable to handle kernel paging request at virtual address 7232b403
  printing eip:
c027bc25
*pde = 00000000
Oops: 0002 [#1]
CPU:    0
EIP:    0060:[<c027bc25>]    Not tainted
EFLAGS: 00010002
EIP is at got_it+0x15/0x40
eax: 7232b2df   ebx: dff92000   ecx: 00000778   edx: dfd67940
esi: dfd67940   edi: 00000286   ebp: 00000000   esp: dff93f10
ds: 007b   es: 007b   ss: 0068
Process swapper (pid: 1, threadinfo=dff92000 task=dff918c0)
Stack: c027bd3b dfd67940 dfd67940 dff93f8c dff93f6c fffffff0 c027d577 dfd67940
        c03b1a06 00000000 c027bc50 00000000 00000000 dfd67940 00001c70 00000000
        dff918c0 c011aa40 dff93f78 dff93f78 00001c70 dff92000 00001c70 00000000
Call Trace:
  [<c027bd3b>] ppa_pb_claim+0x7b/0x80
  [<c027d577>] __ppa_attach+0x127/0x350
  [<c027bc50>] ppa_wakeup+0x0/0x70
  [<c011aa40>] autoremove_wake_function+0x0/0x50
  [<c011aa40>] autoremove_wake_function+0x0/0x50
  [<c023a746>] parport_register_driver+0x36/0x70
  [<c0485b83>] ppa_driver_init+0x23/0x30
  [<c046e74c>] do_initcalls+0x2c/0xa0
  [<c012c9ff>] init_workqueues+0xf/0x30
  [<c01050d2>] init+0x32/0x140
  [<c01050a0>] init+0x0/0x140
  [<c0106fe9>] kernel_thread_helper+0x5/0xc

Code: c7 80 24 01 00 00 01 00 00 00 c3 8b 42 50 b9 01 00 00 00 ba
  <0>Kernel panic: Attempted to kill init!

