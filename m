Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264299AbUEXOlg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264299AbUEXOlg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 10:41:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264304AbUEXOlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 10:41:36 -0400
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:52722 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S264299AbUEXOle (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 10:41:34 -0400
Date: Mon, 24 May 2004 16:41:32 +0200
From: Christoph Pleger <Christoph.Pleger@uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: iptables and bootp
Message-Id: <20040524164132.7f68e581.Christoph.Pleger@uni-dortmund.de>
Organization: Universitaet Dortmund
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; sparc-sun-solaris2.6)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm using the following commands to drop all traffic to and from the
bootp-port of one of my machines:

iptables -I INPUT -i eth0 -p tcp --destination-port bootps -j DROP
iptables -I INPUT -i eth0 -p udp --destination-port bootps -j DROP
iptables -I OUTPUT -o eth0 -p tcp --source-port bootps -j DROP
iptables -I OUTPUT -o eth0 -p udp --source-port bootps -j DROP

But this machine gives a reply to another machine's bootp-request that
was created by the program "bootpc" (it is not possible that that answer
comes from another bootp-Server). Iptables-Statistics show that
UDP-packets to the bootps-port have been dropped, but obviously that has
not really happened (as shown by tcpdump). Dropped outgoing packets from
port bootps do not appear in the statistics. 

When I change the port number in the above commands (for example, to
20003), the packets are actually blocked.

Does somebody have any advice?

Kind regards
  Christoph Pleger
