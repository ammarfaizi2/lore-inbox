Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261665AbULZPBt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261665AbULZPBt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 10:01:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261667AbULZPBt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 10:01:49 -0500
Received: from ferdi.naasa.net ([212.8.0.5]:5125 "EHLO ferdi.naasa.net")
	by vger.kernel.org with ESMTP id S261665AbULZPBr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 10:01:47 -0500
From: Joerg Platte <lists@naasa.net>
Reply-To: lists@naasa.net
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.6.10 with IPSEC problems?
Date: Sun, 26 Dec 2004 15:53:23 +0100
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200412261553.24178.lists@naasa.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

After an upgrade from 2.6.9 to 2.6.10 my IPSEC tunnel does not work as usual. 
My computer and the VPN-gateway can negotiate and build a tunnel and packets 
can use the tunnel. But then packets which must be routed get lost somewhere 
inside the kernel. tcpdump shows them first encrypted in ESP packets and then 
the unencrypted payload on the same interface. But they do not leave the 
kernel on the destination interface. Only packets with my computer as 
destination are processed. I did not change my IPSEC configuration and the 
kernel was configured using "make oldconfig".

Is there a problem in the routing layer somewhere inside the kernel or an 
internal change which requires a configuration change on my side? How can I 
determine, where and why the packets inside the kernel are thrown away?

To verify the problem I build a 2.6.10 kernel on the VPN gateway. And this 
kernel seems to have the same problem. Previously encrypted packets are not 
routed to th destination.

Downgrading to 2.6.9 solved the problem in both cases...

Regards,
Jörg
