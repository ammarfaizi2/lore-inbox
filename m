Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261981AbTHTOdV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 10:33:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261985AbTHTOdV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 10:33:21 -0400
Received: from locust.csie.ncku.edu.tw ([140.116.247.131]:48563 "EHLO
	locust.csie.ncku.edu.tw") by vger.kernel.org with ESMTP
	id S261981AbTHTOdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 10:33:20 -0400
Date: Wed, 20 Aug 2003 22:29:32 +0800 (CST)
From: Po-Chou Su <supc@locust.csie.ncku.edu.tw>
Message-Id: <200308201429.h7KETWo13962@locust.csie.ncku.edu.tw>
Subject: question:source address selection
To: linux-kernel@vger.kernel.org
Content-Type: text
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
If the current code with Linux kernel 2.4.18 will also pick up the first one
address it finds ?
Assume that I have 2 IPv6 addresses (3ffe:3600:1b::1999, 3ffe:3600:1c:2999)
on eth0

I tried it on my RedHat 8.0, it always choose the same ipv6 address
(3ffe:3600:1b::1999) to internet,
but when I check the soure code, it shows as below

/*
 * Choose an apropriate source address
 * should do:
 * i) get an address with an apropriate scope
 * ii) see if there is a specific route for the destination and use
 *  an address of the attached interface
 * iii) don't use deprecated addresses
 */
int ipv6_get_saddr(struct dst_entry *dst,
     struct in6_addr *daddr, struct in6_addr *saddr)


Why this does not work ? or when it will work ?
Suggestion is needed. Thanks.

Regards,
PC


