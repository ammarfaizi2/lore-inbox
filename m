Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267186AbTGZSkg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 14:40:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267317AbTGZSkf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 14:40:35 -0400
Received: from clt57-148-234.carolina.rr.com ([66.57.148.234]:49140 "EHLO
	carolina.rr.com") by vger.kernel.org with ESMTP id S267186AbTGZSkf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 14:40:35 -0400
To: linux-kernel@vger.kernel.org
Subject: multiple readers for stack-processed net traffic
Message-Id: <20030726185155.749E63006@carolina.rr.com>
Date: Sat, 26 Jul 2003 14:51:55 -0400 (EDT)
From: vax@carolina.rr.com (VaX#n8)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I'd like to be able to create a second "tap" for application data that
presents data exactly as the application sees it, and in such a way that
guarantees that both applications read the data before it is freed or
acknowledged.  I have skimmed the Coriolis book on the 2.0 IP stacks (yes,
I know it's old), and it seems like the most direct way to do this is to
alter tcp_recvmsg and udp_rcv, probably using an LKM.  I have not given
much thought yet about how this second application will indicate that it
wants to snoop on given sockets, though.  I was wondering if any of you
kernel gurus have any suggestions on how to accomplish the above goals.

Thanks,
VaX#n8
