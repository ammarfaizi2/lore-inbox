Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261673AbULFWE0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261673AbULFWE0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 17:04:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261678AbULFWE0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 17:04:26 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:48357 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261673AbULFWEM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 17:04:12 -0500
Subject: constructing IPv6 in6_addr structure from ipv6
From: Steve French <smfltc@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: xma@us.ibm.com
Content-Type: text/plain
Organization: IBM - Linux Technology Center
Message-Id: <1102370644.1855.13.camel@stevef95.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 06 Dec 2004 16:04:04 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there a recommended way to construct a struct sockaddr_in6 in kernel
which is the format the connect function on a socket requires for ipv6
addresses?

Basically this boils down to how to best construct a struct in6_addr
starting with a IPv6 network address represented as a familiar dotted
address character string.   I would prefer to convert this in kernel via
something like inet_pton(AF_INET6,original_address_string,
converted_to_in6_add_form) but I could convert in userspace and pass the
16 byte array down to the kernel mangled as a string, via a mount
option.

Is it better to mangle the address and pass it down, or do something
similar to inet_pton?   This can't be the first time that someone has
wanted to deal with an ipv6 address coming from userspace ...





