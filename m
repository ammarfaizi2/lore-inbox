Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262142AbUCaRWY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 12:22:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262213AbUCaRUU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 12:20:20 -0500
Received: from fw.osdl.org ([65.172.181.6]:13799 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262142AbUCaRQ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 12:16:56 -0500
Date: Wed, 31 Mar 2004 09:16:46 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Powers-of-two - 7 for recv() length??
Message-Id: <20040331091646.4b1e0e70@dell_ss3.pdx.osdl.net>
In-Reply-To: <Pine.LNX.4.53.0403311128200.11700@chaos>
References: <Pine.LNX.4.53.0403311128200.11700@chaos>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.9claws (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What is the socket send/receive buffering, and the underlying network.
You need to look at the data flow with something like tcpdump and tcptrace.
If you get flow controlled or lots of other reasons, TCP will validly
send a small number of bytes (like 1) which will get things out of alignment.
