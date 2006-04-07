Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964883AbWDGUOx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964883AbWDGUOx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 16:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932453AbWDGUOx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 16:14:53 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:10967
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932451AbWDGUOx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 16:14:53 -0400
Date: Fri, 07 Apr 2006 13:14:45 -0700 (PDT)
Message-Id: <20060407.131445.02462792.davem@davemloft.net>
To: heiko.carstens@de.ibm.com
Cc: jgarzik@pobox.com, akpm@osdl.org, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, fpavlic@de.ibm.com
Subject: Re: [patch] ipv4: initialize arp_tbl rw lock
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060407081533.GC11353@osiris.boeblingen.de.ibm.com>
References: <20060407081533.GC11353@osiris.boeblingen.de.ibm.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>
Date: Fri, 7 Apr 2006 10:15:33 +0200

> From: Heiko Carstens <heiko.carstens@de.ibm.com>
> 
> The qeth driver makes use of the arp_tbl rw lock. CONFIG_DEBUG_SPINLOCK
> detects that this lock is not initialized as it is supposed to be.
> 
> Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>

As Stephen Hemminger pointed out this change is bogus, the
lock is initialized at run time by the ARP layer.
