Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269298AbUJFPmj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269298AbUJFPmj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 11:42:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269289AbUJFPhz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 11:37:55 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:26587 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S262406AbUJFPcP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 11:32:15 -0400
Message-ID: <41640FAF.9060303@nortelnetworks.com>
Date: Wed, 06 Oct 2004 09:30:55 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: "David S. Miller" <davem@davemloft.net>,
       Joris van Rantwijk <joris@eljakim.nl>, linux-kernel@vger.kernel.org
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
References: <Pine.LNX.4.58.0410061616420.22221@eljakim.netsystem.nl> <20041006080104.76f862e6.davem@davemloft.net> <Pine.LNX.4.61.0410061110260.6661@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0410061110260.6661@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> On Wed, 6 Oct 2004, David S. Miller wrote:

>> There is no such guarentee.
> Huh?  Then why would anybody use select()?  

To tell you when to try a nonblocking read?

 > It can't return a
> 'guess" or it's broken. When select() or poll() claims that
> there are data available, there damn well better be data available
> or software becomes a crap-game.

In the single-threaded case, where you are the only one touching the socket, I 
would expect this to be true.  But since I'm a belt-and-suspenders kind of guy, 
I usually use nonblocking reads anyway.

Chris
