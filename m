Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268485AbTCABIU>; Fri, 28 Feb 2003 20:08:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268484AbTCABIU>; Fri, 28 Feb 2003 20:08:20 -0500
Received: from pizda.ninka.net ([216.101.162.242]:27544 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S268483AbTCABIS>;
	Fri, 28 Feb 2003 20:08:18 -0500
Date: Fri, 28 Feb 2003 17:01:24 -0800 (PST)
Message-Id: <20030228.170124.03146870.davem@redhat.com>
To: shemminger@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: Possible FIFO race in lock_sock()
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1046467548.30194.258.camel@dell_ss3.pdx.osdl.net>
References: <1046467548.30194.258.camel@dell_ss3.pdx.osdl.net>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Stephen Hemminger <shemminger@osdl.org>
   Date: 28 Feb 2003 13:25:50 -0800
   
   Don't know what this impacts, perhaps out of order data on a pipe?

There's a race to get the lock, who cares?

If multiple people are playing with the socket, the exact pieces of
data they happen to get is random unless the application does
it's own locking.

