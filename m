Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932548AbVJZFbU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932548AbVJZFbU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 01:31:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932550AbVJZFbU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 01:31:20 -0400
Received: from webmailv3.ispgateway.de ([80.67.16.113]:3790 "EHLO
	webmailv3.ispgateway.de") by vger.kernel.org with ESMTP
	id S932548AbVJZFbT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 01:31:19 -0400
Message-ID: <1130304672.435f14a0819ca@www.domainfactory-webmail.de>
Date: Wed, 26 Oct 2005 07:31:12 +0200
From: Florian Engelhardt <flo@dotbox.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.14-rc5-mm1 wont compile
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.8
X-Originating-IP: 213.143.195.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

i patched the vanilla 2.6.13 with the 2.6.14-rc5 patch
and after that with the 2.6.14-rc5-mm1 patch, configured the
kernel and executed make:

  CC      net/core/filter.o
In file included from include/net/request_sock.h:22,
                 from include/linux/ip.h:84,
                 from include/net/ip.h:28,
                 from net/core/filter.c:28:
include/net/sock.h: In function `sk_dst_get':
include/net/sock.h:972: warning: implicit declaration of function
`__raw_read_unlock'
include/net/sock.h: In function `sk_dst_set':
include/net/sock.h:991: warning: implicit declaration of function
`__raw_write_unlock'
  CC      net/core/net-sysfs.o
In file included from net/core/net-sysfs.c:16:
include/net/sock.h: In function `sk_dst_get':
include/net/sock.h:972: warning: implicit declaration of function
`__raw_read_unlock'
include/net/sock.h: In function `sk_dst_set':
include/net/sock.h:991: warning: implicit declaration of function
`__raw_write_unlock'
  LD      net/core/built-in.o
  CC      net/ethernet/eth.o
In file included from include/net/request_sock.h:22,
                 from include/linux/ip.h:84,
                 from net/ethernet/eth.c:49:
include/net/sock.h: In function `sk_dst_get':
include/net/sock.h:972: warning: implicit declaration of function
`__raw_read_unlock'
include/net/sock.h: In function `sk_dst_set':
include/net/sock.h:991: warning: implicit declaration of function
`__raw_write_unlock'
  CC      net/ethernet/sysctl_net_ether.o
  LD      net/ethernet/built-in.o
  CC      net/ipv4/route.o
In file included from include/linux/mroute.h:129,
                 from net/ipv4/route.c:89:
include/net/sock.h: In function `sk_dst_get':
include/net/sock.h:972: warning: implicit declaration of function
`__raw_read_unlock'
include/net/sock.h: In function `sk_dst_set':
include/net/sock.h:991: warning: implicit declaration of function
`__raw_write_unlock'
net/ipv4/route.c: In function `rt_check_expire':
net/ipv4/route.c:663: warning: dereferencing `void *' pointer
net/ipv4/route.c:663: error: request for member `raw_lock' in something not a
structure or union
make[2]: *** [net/ipv4/route.o] Error 1
make[1]: *** [net/ipv4] Error 2
make: *** [net] Error 2


Kind regards

Flo

