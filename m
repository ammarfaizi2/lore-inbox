Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275064AbTHLEfi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 00:35:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275066AbTHLEfi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 00:35:38 -0400
Received: from albatross.mail.pas.earthlink.net ([207.217.120.120]:25798 "EHLO
	albatross.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S275064AbTHLEfh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 00:35:37 -0400
Subject: NAT + IPsec in 2.6.0-test2
From: Tom Sightler <ttsig@tuxyturvy.com>
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1060662905.1840.103.camel@iso-8590-lx.zeusinc.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 12 Aug 2003 00:35:06 -0400
Content-Transfer-Encoding: 7bit
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-0.6, required 10,
	AWL, SPAM_PHRASE_00_01)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, I finally got racoon to work and have IPsec working great with a
2.6.0-test2-mm1 kernel on my home Internet gateway system.  However,
I've hit another issue.  In my previous setup with the 2.4.20 kernel and
SuperFreeS/WAN it looked like this

10.0.0.0/8--205.242.242.161<-IPsec->66.3.2.1--{10.250.1.129/32}--192.168.1.0/24

Basically the IPsec tunnel had only a single IP address on the remote
end then any packets from the home internal network (192.168.1.0) were
SNAT to the 10.250.1.129 before being sent via the tunnel.  This hid my
home network behind a valid IP at my work network and worked flawlessly
with 2.4 and SuperFreeS/WAN.

I've got the identical setup with kernel 2.6 and racoon.  I get the
tunnel up and everything works great from the gateway system, but none
of the systems on my home network can access the systems on the work
network.  It seems that packets passing via IPsec are bypassing the NAT
rules, although that's mostly just a guess at this point.

Is there anything written that describes how the kernels IPsec
implementations interacts with iptables?  I've searched the linux-kernel
archives and Google but turned up empty (although I found the question
asked one time before).  Any help would be greatly appreciated.

Later,
Tom
 


