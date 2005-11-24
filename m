Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932155AbVKXPgY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155AbVKXPgY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 10:36:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932158AbVKXPgY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 10:36:24 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:53708 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S932155AbVKXPgX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 10:36:23 -0500
To: linux-kernel@vger.kernel.org
Subject: netlink multicast then unicast
From: "Linh Dang" <linhd@nortel.com>
Organization: Null
Date: Thu, 24 Nov 2005 10:36:03 -0500
Message-ID: <wn5sltmxdlo.fsf@linhd-2.ca.nortel.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi

In netlink_sendmsg(), what's the reason for the unicast that follow
the multicast? shouldn't there be an `else' there? I.e. if it's a
multicast then dont unicast.

 	if (dst_group) {
		atomic_inc(&skb->users);
		netlink_broadcast(sk, skb, dst_pid, dst_group, GFP_KERNEL);
	}
	err = netlink_unicast(sk, skb, dst_pid, msg->msg_flags&MSG_DONTWAIT);


Thx

-- 
Linh Dang
