Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262448AbSJIWmz>; Wed, 9 Oct 2002 18:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262443AbSJIWmw>; Wed, 9 Oct 2002 18:42:52 -0400
Received: from pizda.ninka.net ([216.101.162.242]:19636 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262448AbSJIWlq>;
	Wed, 9 Oct 2002 18:41:46 -0400
Date: Wed, 09 Oct 2002 15:40:20 -0700 (PDT)
Message-Id: <20021009.154020.99148626.davem@redhat.com>
To: vividh@ipinfusion.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Interface address change netlink socket
 problem.(Patch attached)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3DA4AEA5.8090105@ipinfusion.com>
References: <3DA4A3A3.2090408@ipinfusion.com>
	<20021009.150818.102229501.davem@redhat.com>
	<3DA4AEA5.8090105@ipinfusion.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Vividh Siddha <vividh@ipinfusion.com>
   Date: Wed, 09 Oct 2002 15:33:09 -0700

   It first calls devinet_ioctl() with cmd as SIOCSIFADDR. In this we reset 
   netmask and broadcast address.

I understand now.

But, I believe that this resetting of the netmask/broadcast address
is required behavior for this SIOCSIFADDR ioctl.

You can use rtnetlink messages to do this more precisely
(f.e. via a tool such as 'ip') and thus to avoid the excessive
netlink messages.

After scanning relevant portions of Stevens Volume II, it seems
the code you are deleting are required behavior of these ioctls
and it is how BSD behaves.
