Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261303AbSJHRum>; Tue, 8 Oct 2002 13:50:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261306AbSJHRum>; Tue, 8 Oct 2002 13:50:42 -0400
Received: from web13115.mail.yahoo.com ([216.136.174.183]:11554 "HELO
	web13115.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S261303AbSJHRul>; Tue, 8 Oct 2002 13:50:41 -0400
Message-ID: <20021008175622.406.qmail@web13115.mail.yahoo.com>
Date: Tue, 8 Oct 2002 10:56:22 -0700 (PDT)
From: devnetfs <devnetfs@yahoo.com>
Subject: zero-copy UDP send in kernel
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have a buffer in kernel (module), which I need to send over the n/w
as UDP pkt. I am creating an socket (sock) and using
sock->ops->sendmsg(). And sendmsg() takes 'struct msghdr' containing a
iovec, which points to my buffer. 

The problem is, sendmsg() internally does an additional copy (from
iovec to an sk_buff). Can this be avoided? I mean can the sk_buff's
data buffer pointers be made to point to my buffer? or something else,
to avoid this 'copying'.

Copying from one region (my buffer) to another (sk_buff) of the kernel
seems to be real _waste_. 

I have heard something about non-linear sk_buff's. Can they be used in
such scenario?

Thanks in Advance,
Abhi.


__________________________________________________
Do you Yahoo!?
Faith Hill - Exclusive Performances, Videos & More
http://faith.yahoo.com
