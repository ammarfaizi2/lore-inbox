Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262636AbUKLWYy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262636AbUKLWYy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 17:24:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262643AbUKLWXI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 17:23:08 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:54211 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262636AbUKLWU7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 17:20:59 -0500
Message-Id: <200411122220.iACMKpjw014426@death.nxdomain.ibm.com>
To: "David S. Miller" <davem@davemloft.net>
cc: radheka.godse@intel.com, bonding-devel@lists.sourceforge.net,
       ctindel@users.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Bonding-devel][PATCH]Zero Copy Transmit Support (Update) 
In-Reply-To: Message from "David S. Miller" <davem@davemloft.net> 
   of "Fri, 12 Nov 2004 13:49:18 PST." <20041112134918.305379c4.davem@davemloft.net> 
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.1
Date: Fri, 12 Nov 2004 14:20:51 -0800
From: Jay Vosburgh <fubar@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller <davem@davemloft.net> wrote:
>That's definitely a good start.
>
>It does need to be fixed to enforce the usual rules about
>illegal combinations.  And his code is going to include
>all sorts of weird things like VLAN offload which I wonder
>if works correctly with the current bonding driver? :)

	The existing code should handle VLANs correctly, and the patch
excludes the VLAN related bits from the dev->features update.

>The two rules are codified in register_netdevice() as follows:
[...]

	Would it be preferrable to duplicate that logic in bonding, or
push it out to an inline or some such?

	-J

---
	-Jay Vosburgh, IBM Linux Technology Center, fubar@us.ibm.com
