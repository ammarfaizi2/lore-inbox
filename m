Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261270AbTEAODj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 10:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261272AbTEAODj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 10:03:39 -0400
Received: from pizda.ninka.net ([216.101.162.242]:52164 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S261270AbTEAODh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 10:03:37 -0400
Date: Thu, 01 May 2003 06:09:09 -0700 (PDT)
Message-Id: <20030501.060909.26990580.davem@redhat.com>
To: Steve@ChyGwyn.com, steve@gw.chygwyn.com
Cc: linux-decnet-user@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       kuznet@ms2.inr.ac.ru
Subject: Re: Remains of seq_file conversion for DECnet, plus fixes
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200305011404.PAA17187@gw.chygwyn.com>
References: <20030501.054523.98892534.davem@redhat.com>
	<200305011404.PAA17187@gw.chygwyn.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Steven Whitehouse <steve@gw.chygwyn.com>
   Date: Thu, 1 May 2003 15:04:00 +0100 (BST)

   > About update_pmtu().  You are not required to implement this.
   > All of these places you see dereferencing dst->update_mtu()
   > know that they have an ipv4/ipv6 route.  Or do you know some
   > exception to this?

   I was thinking of that bit of code in ip_gre.c which I sent the fix for
   recently. Unless I've missed something it calls update_pmtu on the dst
   which is passed by the encapsulated protocol, although I've not actually
   tested that.
   
   Thats the reason I wasn't sure about the fix which I sent... it deleted the
   duplicated call only for IPv4 rather than the one which appears to get called
   for every protocol as I wasn't sure what was intended.
   
No, this must be an IPV4 or an IPV6 route.
Right Alexey?
