Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262496AbVAPNLh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262496AbVAPNLh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 08:11:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262499AbVAPNLh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 08:11:37 -0500
Received: from web52210.mail.yahoo.com ([206.190.39.92]:2944 "HELO
	web52210.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262498AbVAPNLb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 08:11:31 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=z9TgQFVu792LnZxsxlGn80OUx1SmHUGQ4G2Zc3OmLAOBZ6Yl1hGy7DoZyY2Wva+EtF8JJ1uN1CRie5JjObjoP8+ftBJEVm6WVqneiobEDU1QPQfwIU0lH0J4wiPdAe2pR0+YFuimx0qH4wInoOGbBrA5Zd8eaxfW/Si/VOvfjeI=  ;
Message-ID: <20050116131131.72317.qmail@web52210.mail.yahoo.com>
Date: Sun, 16 Jan 2005 05:11:31 -0800 (PST)
From: linux lover <linux_lover2004@yahoo.com>
Subject: Analysing UDP packet building code in 2.6.10 kernel
To: linux-net@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello all,
         I am knowing all 2.4 kernel network stack
packet buildup procedure. Now i am trying to analysing
same in
2.6.10 kernel. What i found is many changes to 2.6
kernel compare to 2.4. Theres is no ip_build_xmit
instead thers a new function that is
ip_append_data. What i want to know is from udp.c
file. Theres a udp protocol structure is defined
struct proto udp_prot = {
 	.name =		"UDP",
	.owner =	THIS_MODULE,
	.close =	udp_close,
	.connect =	ip4_datagram_connect,
	.disconnect =	udp_disconnect,
	.ioctl =	udp_ioctl,
	.destroy =	udp_destroy_sock,
	.setsockopt =	udp_setsockopt,
	.getsockopt =	udp_getsockopt,
	.sendmsg =	udp_sendmsg,
	.recvmsg =	udp_recvmsg,
	.sendpage =	udp_sendpage,
	.backlog_rcv =	udp_queue_rcv_skb,
	.hash =		udp_v4_hash,
	.unhash =	udp_v4_unhash,
	.get_port =	udp_v4_get_port,
	.slab_obj_size = sizeof(struct udp_sock),
};

I want to know for what purpose udp_sendpage is used
also whats significance of . in structure members?
Also why .slab_obj_size = sizeof(struct udp_sock)
defined in udp_prot?
Also where's packet size/space is allocated for UDP
packet?
Please help me to analyze code.
Thanks in advance.
linux_lover.



		
__________________________________ 
Do you Yahoo!? 
Take Yahoo! Mail with you! Get it on your mobile phone. 
http://mobile.yahoo.com/maildemo 
