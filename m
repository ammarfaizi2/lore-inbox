Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262254AbTFOPON (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 11:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262261AbTFOPON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 11:14:13 -0400
Received: from pizda.ninka.net ([216.101.162.242]:45766 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262254AbTFOPOM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 11:14:12 -0400
Date: Sun, 15 Jun 2003 08:23:55 -0700 (PDT)
Message-Id: <20030615.082355.08334189.davem@redhat.com>
To: James.Bottomley@SteelEye.com
Cc: acme@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: New struct sock_common breaks parisc 64 bit compiles with a
 misalignment
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1055690231.10803.54.camel@mulgrave>
References: <1055687753.10803.28.camel@mulgrave>
	<20030615.073503.112613460.davem@redhat.com>
	<1055690231.10803.54.camel@mulgrave>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: James Bottomley <James.Bottomley@SteelEye.com>
   Date: 15 Jun 2003 10:17:10 -0500
   
   It's not necessary and would, indeed, be detrimental to operation since
   we'd generate alignment traps on almost every encapsulated protocol (at
   several hundred instructions per trap).  If we do this, our network
   performance will tank.

It doesn't happen for all the normal cases, but it does for
things like IP in appletalk and stuff like that.

Please, implement the trap handlers.  Thanks.
