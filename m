Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318309AbSG3Ojs>; Tue, 30 Jul 2002 10:39:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318310AbSG3Ojs>; Tue, 30 Jul 2002 10:39:48 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:9726 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318309AbSG3Ojs>; Tue, 30 Jul 2002 10:39:48 -0400
Subject: Re: Weirdness with AF_INET listen() backlog [2.4.18]
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Michael Kerrisk <m.kerrisk@gmx.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <7911.1028039755@www55.gmx.net>
References: <7911.1028039755@www55.gmx.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 30 Jul 2002 16:59:22 +0100
Message-Id: <1028044762.6726.44.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-07-30 at 15:35, Michael Kerrisk wrote:
> I had expected that if a server creates a listening socket, but does not
> accept() the incoming connections, then after the (possibly fudge-factored)
> Is this all expected behaviour?  If so, is there a way of getting Linux to
> behave more like other implementations here?  (As a wild shot I tried setting
> /proc/sys/net/ipv4/tcp_syncookies to 0, but this made no apparent
> difference.)

The world of tcp synflooding changed how stacks handle this sort of
stuff forever. Welcome to the new world order 8)

You will get connections completing, they will time out. If you expect
the server to say something you'll see the timeout there instead of
seeing it on the connect. 

Since a timeout on the data can happen in the real world Im sure your
code already correctly handles this case ;)

