Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293515AbSCOXk2>; Fri, 15 Mar 2002 18:40:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293521AbSCOXkT>; Fri, 15 Mar 2002 18:40:19 -0500
Received: from pizda.ninka.net ([216.101.162.242]:50081 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S293515AbSCOXkH>;
	Fri, 15 Mar 2002 18:40:07 -0500
Date: Fri, 15 Mar 2002 15:37:05 -0800 (PST)
Message-Id: <20020315.153705.111545634.davem@redhat.com>
To: alan@lxorguk.ukuu.org.uk
Cc: davids@webmaster.com, linux-kernel@vger.kernel.org
Subject: Re: RFC2385 (MD5 signature in TCP packets) support
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <E16m1J7-00051f-00@the-village.bc.nu>
In-Reply-To: <20020315.151628.122227750.davem@redhat.com>
	<E16m1J7-00051f-00@the-village.bc.nu>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Alan Cox <alan@lxorguk.ukuu.org.uk>
   Date: Fri, 15 Mar 2002 23:40:21 +0000 (GMT)

   > Ignoring valid RST frames breaks TCP.
   
   If they don't have the right MD5 frame they are not valid.

If there is an error in the network stack there is no way for
a remote TCP to fix things.  Making RST frames more complex
guarentees that more error conditions will not be broken out of.

A RST must, in order to function properly, be as simple and non-error
prone as possible.  MD5 signatures are totally against that.

This is why PAWS timestamp, etc. checks are DISABLED for RST frames.
Only the sequence number is verified, but that is it.

   IPSEC has a lot more going for it, but most cisco's still only
   support the MD5 stuff.
   
I frankly don't care what Cisco's do or do not do.

I don't care if Cisco made a rotten decision.  I'm not going to let
Cisco's mistakes crap up Linux's networking.   

Either use IPSEC or fix its' deficiencies.
