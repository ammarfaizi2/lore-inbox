Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262214AbSJATZ2>; Tue, 1 Oct 2002 15:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262227AbSJATZ1>; Tue, 1 Oct 2002 15:25:27 -0400
Received: from web13107.mail.yahoo.com ([216.136.174.152]:38921 "HELO
	web13107.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S262214AbSJATYu>; Tue, 1 Oct 2002 15:24:50 -0400
Message-ID: <20021001193014.6899.qmail@web13107.mail.yahoo.com>
Date: Tue, 1 Oct 2002 20:30:14 +0100 (BST)
From: =?iso-8859-1?q?will=20fitzgerald?= <linux_learning@yahoo.co.uk>
Subject: expanding on t these functions do!
To: linux-c-programming@vger.kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi all,


 i was hoping someone could explain what is it exactly
that each of these functions actually do.i have
supplied what i think they do under each of them.i'm
using kernel 2.4.14 (old i know!!!!)

skb_bond() in dev.c
net_rx_action() calls it, it returns and then
net_rx_action calls ip_rcv() but what is skb_bond
doing?

 skb_shared() in skbuff.h
  ip_rcv() calls it befoe doing a NF_HOOK to call
ip_rcv_finish() again i'm not sure of what it does.

skb_cloned() in skbuff.h
it seems to be linked to skb_shared() according to the
comments.  ip_forwad() calls  calling
rt_tos2priority() and skb_cow() and skb_cow calls
skb_cloned().
what is skb cloned used for?

rt_tos2priority in route.h
  does it give security priority information? even
though i don't have a firewall set on my linux router
(experimenting with networks, hobbie) , it gets called
  as i have inserted printk's to test if it gets
called.

ip_decrease_ttl() in net/ip.h
 whats the purpose of this?

ip_send() in net/ip.h
ip_forward_finish() calls this function. what does
this line "skb->len > skb->dst->pmtu" do in order to
make the decision of calling one of two functions?

neigh_resolve_output() in neighbour.c
this calls the next two functions below. its called
from ip_finish_output2(). does this lookup fib tables
or cahces etc?

neigh_event_send() in neighbour.h

what does this function check in order to call the
next function:   __neigh_event_send(neigh, skb)
   
__neigh_event_send() in neighbour.c
what exactly is going on here? after the above
function has returned its result this one gets
executed.


thank you for your time,
regards.






__________________________________________________
Do You Yahoo!?
Everything you'll ever need on one web page
from News and Sport to Email and Music Charts
http://uk.my.yahoo.com
