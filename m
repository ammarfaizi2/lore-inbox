Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293525AbSCASxw>; Fri, 1 Mar 2002 13:53:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293519AbSCASxd>; Fri, 1 Mar 2002 13:53:33 -0500
Received: from pizda.ninka.net ([216.101.162.242]:1672 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S293517AbSCASxP>;
	Fri, 1 Mar 2002 13:53:15 -0500
Date: Fri, 01 Mar 2002 10:50:57 -0800 (PST)
Message-Id: <20020301.105057.75255265.davem@redhat.com>
To: akpm@zip.com.au
Cc: aferber@techfak.uni-bielefeld.de, jgarzik@mandrakesoft.com,
        greearb@candelatech.com, linux-kernel@vger.kernel.org,
        linux-net@vger.kernel.org
Subject: Re: Various 802.1Q VLAN driver patches. [try2]
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3C7FCC53.4E270646@zip.com.au>
In-Reply-To: <3C7FADBB.3A5B338F@mandrakesoft.com>
	<20020301174619.A6125@devcon.net>
	<3C7FCC53.4E270646@zip.com.au>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andrew Morton <akpm@zip.com.au>
   Date: Fri, 01 Mar 2002 10:45:39 -0800

   +#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
   
   Is this avoidable somehow?

It's stupid to have all the overhead when vlans aren't even
being built into the kernel.

That was my original impetus.

It's costly in some cases, when you have the TXDs on the chip
you can avoid an entire PIO for each packet.
