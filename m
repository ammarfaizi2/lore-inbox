Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261581AbTIZSx2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 14:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261582AbTIZSx2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 14:53:28 -0400
Received: from path.emicnetworks.com ([194.137.152.194]:38017 "EHLO mail.emic")
	by vger.kernel.org with ESMTP id S261581AbTIZSx0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 14:53:26 -0400
Date: Fri, 26 Sep 2003 21:53:26 +0300
From: "Alexey V. Yurchenko" <ayurchen@mail.emicnetworks.com>
To: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: how to set multicast MAC ligitemately?
Message-Id: <20030926215326.23f7de24.ayurchen@mail.emicnetworks.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, everybody

In view of include/linux/etherdevice.h:

...
/**
 * is_valid_ether_addr - Determine if the given Ethernet address is valid
 * @addr: Pointer to a six-byte array containing the Ethernet address
 *
 * Check that the Ethernet address (MAC) is not 00:00:00:00:00:00, is not
 * a multicast address, and is not FF:FF:FF:FF:FF:FF.  The multicast
 * and FF:FF:... tests are combined into the single test "!(addr[0]&1)".
 *
 * Return true if the address is valid.
 */
static inline int is_valid_ether_addr( u8 *addr )
{
        const char zaddr[6] = {0,};
                                                                          
        return !(addr[0]&1) && memcmp( addr, zaddr, 6);
}
...

how it is possible to set up multicast MAC address legitemately if NIC driver resorts to use of this function. Why are multicast addresses forbidden and who is the right person to ask?

(I really do need to set a multicast MAC address, and if multicast MAC addresses exist, why are they forbidden?)

Regards,
Alex
