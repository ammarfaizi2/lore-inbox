Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293527AbSCOXsj>; Fri, 15 Mar 2002 18:48:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293531AbSCOXs2>; Fri, 15 Mar 2002 18:48:28 -0500
Received: from pizda.ninka.net ([216.101.162.242]:59297 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S293527AbSCOXs0>;
	Fri, 15 Mar 2002 18:48:26 -0500
Date: Fri, 15 Mar 2002 15:45:27 -0800 (PST)
Message-Id: <20020315.154527.98068496.davem@redhat.com>
To: alan@lxorguk.ukuu.org.uk
Cc: davids@webmaster.com, linux-kernel@vger.kernel.org
Subject: Re: RFC2385 (MD5 signature in TCP packets) support
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <E16m1bl-000554-00@the-village.bc.nu>
In-Reply-To: <20020315.153705.111545634.davem@redhat.com>
	<E16m1bl-000554-00@the-village.bc.nu>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Alan Cox <alan@lxorguk.ukuu.org.uk>
   Date: Fri, 15 Mar 2002 23:59:36 +0000 (GMT)

   What do you think Ipsec does with an RST frame with an incorrect
   IP-AH MD5 signature ? Exactly the same thing.
   
IPsec is fundamentally different because it encapsulates all IP
traffic, not just TCP.  The packet is killed at IP if it doesn't
pass the signature.

   I'm not saying the RFC is a good idea (tho its a needed patch to
   use Linux for backbone routing sanely with most vendors BGP
   kit). Your argument about the RST frame is however pure horseshit
   
I totally disagree.

Look, TCP is the last place more complexity needs to exist.
Errors in logic in TCP need to be dealt with by breaking the
connection and spitting a RST out, and it must be done in a
way that is as easy to verify as possible.

IPSEC getting the signature wrong is more akin to getting bitstream
corruptions from your networking card for a certain sequence of bytes.
