Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263189AbREWR7e>; Wed, 23 May 2001 13:59:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263193AbREWR7O>; Wed, 23 May 2001 13:59:14 -0400
Received: from mail1-gui.server.ntli.net ([194.168.222.13]:41166 "EHLO
	mail1-gui.server.ntli.net") by vger.kernel.org with ESMTP
	id <S263190AbREWR7G>; Wed, 23 May 2001 13:59:06 -0400
Date: Wed, 23 May 2001 18:59:02 +0100 (BST)
From: Ben Mansell <linux-kernel@slimyhorror.com>
X-X-Sender: <ben@baphomet.bogo.bogus>
To: <linux-kernel@vger.kernel.org>
Subject: Selectively refusing TCP connections
Message-ID: <Pine.LNX.4.33.0105231841230.1163-100000@baphomet.bogo.bogus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Is there any mechanism in Linux for refusing incoming TCP connections?
I'd like to be able to fetch the next incoming connection on a listen
queue, and selectively accept or reject it based on the IP address of the
client. I know this could be done via firewall rules, but for this case,
I'd like an application to have the final say on whether the connection
will be accepted.

I think XTI used to offer this kind of thing, you could get notification
of a new connection when the initial SYN was received, so you could send
back a RST and finish it there and then. Otherwise, you have to go through
the bother of accepting the connection then closing it down properly. Of
course, since everyone uses sockets, and the socket API doesn't provide
this facility, it looks like this feature has ben dropped almost
everywhere.

So, any suggestions?


Thanks,
Ben

