Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289938AbSAKMaL>; Fri, 11 Jan 2002 07:30:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289937AbSAKM3v>; Fri, 11 Jan 2002 07:29:51 -0500
Received: from pizda.ninka.net ([216.101.162.242]:52865 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S289936AbSAKM3n>;
	Fri, 11 Jan 2002 07:29:43 -0500
Date: Fri, 11 Jan 2002 04:28:44 -0800 (PST)
Message-Id: <20020111.042844.70219945.davem@redhat.com>
To: timothy.covell@ashavan.org
Cc: zhengpei@msu.edu, linux-kernel@vger.kernel.org
Subject: Re: strange kernel message when hacking the NIC driver
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200201111224.g0BCOYSr001179@svr3.applink.net>
In-Reply-To: <200201111159.g0BBxCSr001144@svr3.applink.net>
	<20020111.040715.48529485.davem@redhat.com>
	<200201111224.g0BCOYSr001179@svr3.applink.net>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Timothy Covell <timothy.covell@ashavan.org>
   Date: Fri, 11 Jan 2002 06:20:42 -0600
   
   True.  I was assuming that the context of the post was
   that the NICs were on the same network link.    
   
I didn't catch that bit.

   Solaris _defaults_ to using the MAC address from the 
   primary (hostname) NIC for the rest of them. 

This has nothing to do with Solaris, it has to do with
open firmware variable settings.  If there is a 'local-mac-address'
property in the device node for the ethernet card, that is what
the drivers use.  Otherwise they use the "host MAC".

If you look, this is what we do under Linux on Sparc too.
