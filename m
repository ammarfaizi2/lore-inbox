Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262657AbSI1Agn>; Fri, 27 Sep 2002 20:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262658AbSI1Agn>; Fri, 27 Sep 2002 20:36:43 -0400
Received: from bigglesworth.mail.be.easynet.net ([212.100.160.67]:47836 "EHLO
	bigglesworth.mail.be.easynet.net") by vger.kernel.org with ESMTP
	id <S262657AbSI1Agh>; Fri, 27 Sep 2002 20:36:37 -0400
Message-ID: <3D94FB89.40400@easynet.be>
Date: Sat, 28 Sep 2002 02:44:57 +0200
From: Luc Van Oostenryck <luc.vanoostenryck@easynet.be>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020605
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: (more) Sleeping function called from illegal context...
References: <20020927233044.GA14234@kroah.com> <3D94EEBF.D6328392@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With CONFIG_PREEMPT=y on an SMP AMD (2CPU):

Sleeping function called from illegal context at slab.c:1374
f79dbe2c c0117094 c0280b00 c02847cb 0000055e f7817b40 c01328fd c02847cb
        0000055e f79da000 f7ede980 c03ecc58 f7817b40 c025af91 c18cf248 c0266b3e
        00000024 000001d0 f79da000 00000286 00000001 bffffc9c c02f63e0 c0266e20
Call Trace:
  [<c0117094>]__might_sleep+0x54/0x58
  [<c01328fd>]kmalloc+0x5d/0x1e0
  [<c025af91>]fib_add_ifaddr+0x61/0x110
  [<c0266b3e>]__sctp_get_local_addr_list+0x9e/0x140
  [<c0266e20>]sctp_netdev_event+0x30/0x60
  [<c01241ae>]notifier_call_chain+0x1e/0x40
  [<c02566f5>]inet_insert_ifa+0x1b5/0x1c0
  [<c02567b4>]inet_set_ifa+0xb4/0xc0
  [<c0257091>]devinet_ioctl+0x511/0x740
  [<c0259897>]inet_ioctl+0x157/0x1b0
  [<c021e276>]sock_ioctl+0x56/0x90
  [<c0150039>]sys_ioctl+0x289/0x2d8
  [<c0107d11>]error_code+0x2d/0x38
  [<c01072cf>]syscall_call+0x7/0xb


