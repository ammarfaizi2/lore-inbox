Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310128AbSCAVNA>; Fri, 1 Mar 2002 16:13:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310127AbSCAVMv>; Fri, 1 Mar 2002 16:12:51 -0500
Received: from pizda.ninka.net ([216.101.162.242]:26505 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S310124AbSCAVMj>;
	Fri, 1 Mar 2002 16:12:39 -0500
Date: Fri, 01 Mar 2002 13:10:04 -0800 (PST)
Message-Id: <20020301.131004.37152108.davem@redhat.com>
To: jgarzik@mandrakesoft.com
Cc: alan@lxorguk.ukuu.org.uk, akpm@zip.com.au,
        aferber@techfak.uni-bielefeld.de, greearb@candelatech.com,
        linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: Various 802.1Q VLAN driver patches. [try2]
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3C7FEA55.2EFFA878@mandrakesoft.com>
In-Reply-To: <E16gu8n-000515-00@the-village.bc.nu>
	<3C7FEA55.2EFFA878@mandrakesoft.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Jeff Garzik <jgarzik@mandrakesoft.com>
   Date: Fri, 01 Mar 2002 15:53:41 -0500
   
   Anyway, using CONFIG_xxx_MODULE has the problem I describe above.

It actually gets used for all the wrong reasons.

For example, in 2.4.x it is used to keep struct sock from bloating up
in include/net/sock.h unless you have all the protocols enabled.

Whereas with Arnaldo's changes in 2.5.x to split all the non-generic
junk out from struct sock, *_MODULE testing is no longer is needed for
that purpose.

Every existing reference I see in my 2.5.x tree for the networking is
"Duh, delete the ifdef".
