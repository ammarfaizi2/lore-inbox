Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261463AbVAXGwR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261463AbVAXGwR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 01:52:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261460AbVAXGwR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 01:52:17 -0500
Received: from ylpvm01-ext.prodigy.net ([207.115.57.32]:1686 "EHLO
	ylpvm01.prodigy.net") by vger.kernel.org with ESMTP id S261468AbVAXGvs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 01:51:48 -0500
From: David Brownell <david-b@pacbell.net>
Subject: Re: Linux 2.6.11-rc2
Date: Sun, 23 Jan 2005 22:51:42 -0800
User-Agent: KMail/1.7.1
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501232251.42394.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm seeing a problem with TCP as accessed through KMail (SuSE 9.2, x86_64).
But oddly enough, only for sending mail, not reading it; and not through
other (reading) applications... it's a regression with respect to rc1 and
earlier kernels.  Basically, it can only send REALLY TINY emails...

What ethereal shows me is roughly:

 - SMTP connect, initial handshake, ok (ACKed later)
 - Send two 1500 byte Ethernet packets
 - Each gets an ICMP destination unreachable, frag needed, next hop MTU 1492
 - ... all retransmits are 1500 bytes not 1492, triggering ICMPs ...

Naturally the connection goes nowhere.  

- Dave
