Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262148AbSJQUer>; Thu, 17 Oct 2002 16:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262152AbSJQUer>; Thu, 17 Oct 2002 16:34:47 -0400
Received: from pizda.ninka.net ([216.101.162.242]:39358 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262148AbSJQUeq>;
	Thu, 17 Oct 2002 16:34:46 -0400
Date: Thu, 17 Oct 2002 13:33:14 -0700 (PDT)
Message-Id: <20021017.133314.60542842.davem@redhat.com>
To: adam@yggdrasil.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.43: "fix old protocol handler pppoe_rcv+0x0/0x124 [pppoe]"
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200210172010.NAA01600@adam.yggdrasil.com>
References: <200210172010.NAA01600@adam.yggdrasil.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Adam J. Richter" <adam@yggdrasil.com>
   Date: Thu, 17 Oct 2002 13:10:56 -0700
   
   	I'm puzzling out exactly change this message is requesting,

Packet receive must be aware of shared skb's (it must make
a copy if it wants to modify packet contents) and it must
be fully SMP threaded.

Then ptype->data is changed to some non-NULL value to indicate that it
is a "new" protocol.
