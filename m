Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752701AbWKBHNw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752701AbWKBHNw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 02:13:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752704AbWKBHNw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 02:13:52 -0500
Received: from smtp.osdl.org ([65.172.181.4]:18828 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752701AbWKBHNv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 02:13:51 -0500
Date: Wed, 1 Nov 2006 23:13:13 -0800
From: Andrew Morton <akpm@osdl.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andi Kleen <ak@muc.de>, Andi Kleen <ak@suse.de>,
       virtualization@lists.osdl.org, Chris Wright <chrisw@sous-sol.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] paravirtualization: header and stubs for
 paravirtualizing critical operations
Message-Id: <20061101231313.4c91a9a9.akpm@osdl.org>
In-Reply-To: <1162376827.23462.5.camel@localhost.localdomain>
References: <20061029024504.760769000@sous-sol.org>
	<20061029024607.401333000@sous-sol.org>
	<200610290831.21062.ak@suse.de>
	<1162178936.9802.34.camel@localhost.localdomain>
	<20061030231132.GA98768@muc.de>
	<1162376827.23462.5.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch breaks `make headers_check' in mysterious ways:

  CHECK   include/linux/netfilter_ipv4/ip_conntrack_tcp.h
  CHECK   include/linux/netfilter_ipv4/ip_conntrack_sctp.h
  CHECK   include/linux/netfilter_ipv4/ip_conntrack_protocol.h
  CHECK   include/linux/netfilter_ipv4/ip_conntrack_helper_h323_types.h
  CHECK   include/linux/netfilter_ipv4/ip_conntrack_helper_h323_asn1.h
  CHECK   include/linux/netfilter_ipv4/ip_conntrack_helper.h
make[2]: *** [/usr/src/devel/usr/include/asm/.check.setup.h] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [asm-i386] Error 2
make[1]: *** Waiting for unfinished jobs....
make: *** [headers_check] Error 2

