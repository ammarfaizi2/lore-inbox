Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262656AbSI1Afs>; Fri, 27 Sep 2002 20:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262657AbSI1Afs>; Fri, 27 Sep 2002 20:35:48 -0400
Received: from bigglesworth.mail.be.easynet.net ([212.100.160.67]:46556 "EHLO
	bigglesworth.mail.be.easynet.net") by vger.kernel.org with ESMTP
	id <S262656AbSI1Afr>; Fri, 27 Sep 2002 20:35:47 -0400
Message-ID: <3D94FB57.40507@easynet.be>
Date: Sat, 28 Sep 2002 02:44:07 +0200
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

Sleeping function called from illegal context at /kernel/l-2.5.39/include/asm/semaphore.h:119
c1b4ff7c c0117094 c0280b00 c02bc680 00000077 f7f78540 c01ffc8c c02bc680
        00000077 c1b4e000 c1b4e000 00000001 c1b4ffdc c1b4ffc0 00000206 f7f78568
        c1b4e000 00000001 c1b4ffdc c01fff35 c01fff00 00000000 00000000 00000000
Call Trace:
  [<c0117094>]__might_sleep+0x54/0x58
  [<c01ffc8c>]usb_hub_events+0x6c/0x2e0
  [<c01fff35>]usb_hub_thread+0x35/0xe0
  [<c01fff00>]usb_hub_thread+0x0/0xe0
  [<c0115500>]default_wake_function+0x0/0x40
  [<c010553d>]kernel_thread_helper+0x5/0x18


