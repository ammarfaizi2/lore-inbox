Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750877AbWIMOkj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750877AbWIMOkj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 10:40:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750883AbWIMOki
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 10:40:38 -0400
Received: from mailout10.sul.t-online.com ([194.25.134.21]:16540 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1750867AbWIMOki convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 10:40:38 -0400
MIME-Version: 1.0
Subject: Error binding socket: address already in use
From: pledr@t-online.de (Peter Lezoch)
To: <linux-kernel@vger.kernel.org>
X-Mailer: T-Online eMail 6.01.0001
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Date: 13 Sep 2006 14:41 GMT
X-Antivirus: avast! (VPS 0637-0, 11.09.2006), Outbound message
X-Antivirus-Status: Clean
Message-ID: <1GNVuW-02KMfw0@fwd29.sul.t-online.de>
X-ID: G-XcAMZd8eE70slYitdw5N0JchPwlF-9jEsRnEBggIiQGsRvXqrGEp
X-TOI-MSGID: df1a499a-4ee4-4456-bfe5-59ca787ba37c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
killing a server task that is operating on a UDP socket( AF_INET, SOCK_DGRAM, IPPROTO_UDP ), leaves the socket in an unclosed state. A subsequently started task, that wants to use the same port, gets from bind above error message.This is, in my opinion, wrong behavior, because of the connectionless nature of UDP. Only reboot solves this situation. It looks, as if in net/socket.c, TCP and UDP are handled in the same way without taking into account the different nature of the protocols?!
How can I overcome this problem ?

kind regards

peter lezoch
