Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261321AbSJULL7>; Mon, 21 Oct 2002 07:11:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261322AbSJULL6>; Mon, 21 Oct 2002 07:11:58 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:33265 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S261321AbSJULL6>; Mon, 21 Oct 2002 07:11:58 -0400
X-Mailer: exmh version 2.5 13/07/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
To: linux-kernel@vger.kernel.org
Cc: netdev@oss.sgi.com
Subject: rtnetlink interface state monitoring problems.
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Date: Mon, 21 Oct 2002 12:18:04 +0100
Message-ID: <27964.1035199084@passion.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm playing with userspace applications which want to monitor the status of 
IrDA and Bluetooth devices. Rather than polling for the interface state 
(this is a handheld device and polling wastes CPU and battery), I want to 
use netlink. 

I have two problems:

 1. I appear to need CAP_NET_ADMIN to bind to the netlink groups which give
	me this  information. I can poll for it just fine, but need 
	elevated privs to be notified. Why is this, and is there a workaround?

 2. Even root doesn't get notification of state changes for Bluetooth
	interfaces, because they're not treated as 'normal' network devices
	like IrDA devices are. I can see the logic behind that -- by why
	is it done differently from IrDA? Is there a way to get notification
	of BT interface state changes?


--
dwmw2


