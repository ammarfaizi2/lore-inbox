Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270655AbRHNSYn>; Tue, 14 Aug 2001 14:24:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270631AbRHNSYe>; Tue, 14 Aug 2001 14:24:34 -0400
Received: from imo-m03.mx.aol.com ([64.12.136.6]:42966 "EHLO
	imo-m03.mx.aol.com") by vger.kernel.org with ESMTP
	id <S270655AbRHNSY0>; Tue, 14 Aug 2001 14:24:26 -0400
Date: Tue, 14 Aug 2001 12:58:57 -0400
From: hochakhung@netscape.net
To: linux-kernel@vger.kernel.org
Subject: problem with TCP zero copy (sendpage)
Message-ID: <516EFCEC.124B959D.0F45C3B8@netscape.net>
X-Mailer: Atlas Mailer 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have been running a module that gets free pages from the kernel, fills it with data and then sends the page to another machine using TCP/IP. Everything works fine for the past month when I was using sock_sendmsg and scatter-gather to send the iovec of pages in one go with MSG_DONTWAIT flag set. 
However, since the last week, I've tried using sock->ops->sendpage for each of the page(with the MSG_MORE flag set except for the last page which is sent with the MSG_DONTWAIT flag set). I also send the header with the sock_sendmsg() function with MSG_MORE set. However, after making these changes, the module crashes after a while(about 5-20 minutes) that gives me: KERNEL bug at Page_alloc.c 191, which corresponds to the following in the source code within the rmqueue() function:
if (BAD_RANGE(zone, page)) {
BUG();
}

Does anyone know where the problem is? Any hint would be greatly appreciated. Thanks a lot.




__________________________________________________________________
Your favorite stores, helpful shopping tools and great gift ideas. Experience the convenience of buying online with Shop@Netscape! http://shopnow.netscape.com/

Get your own FREE, personal Netscape Mail account today at http://webmail.netscape.com/

