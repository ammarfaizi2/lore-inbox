Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262263AbTFOOZZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 10:25:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262269AbTFOOZY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 10:25:24 -0400
Received: from pizda.ninka.net ([216.101.162.242]:22214 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262263AbTFOOZY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 10:25:24 -0400
Date: Sun, 15 Jun 2003 07:35:03 -0700 (PDT)
Message-Id: <20030615.073503.112613460.davem@redhat.com>
To: James.Bottomley@SteelEye.com
Cc: acme@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: New struct sock_common breaks parisc 64 bit compiles with a
 misalignment
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1055687753.10803.28.camel@mulgrave>
References: <1055221067.11728.14.camel@mulgrave>
	<1055657946.6481.6.camel@rth.ninka.net>
	<1055687753.10803.28.camel@mulgrave>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: James Bottomley <James.Bottomley@SteelEye.com>
   Date: 15 Jun 2003 09:35:52 -0500
   
   Unaligned access traps are pretty expensive on the parisc, so we
   don't actually handle them when they're from the kernel, we panic
   instead (and expect the problem code to be fixed).

Welcome to the real world, unaligned accesses are perfectly
legal in the networking stack.

They are in fact guarenteed to occur when certain protocols
are encapsulated in others.

Please add an unaligned trap handler for parisc64, thanks.
