Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261315AbTIOMfh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 08:35:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261327AbTIOMfg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 08:35:36 -0400
Received: from smtp6.wanadoo.fr ([193.252.22.28]:64173 "EHLO
	mwinf0304.wanadoo.fr") by vger.kernel.org with ESMTP
	id S261315AbTIOMfa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 08:35:30 -0400
Message-ID: <3F65B32E.2050102@wanadoo.fr>
Date: Mon, 15 Sep 2003 14:40:14 +0200
From: =?ISO-8859-1?Q?R=E9mi_Colinet?= <remi.colinet@wanadoo.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kernel List <linux-kernel@vger.kernel.org>
Subject: [2.6.0-test5/-mm2] : compile error with CONFIG_NETFILTER_DEBUG defined
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have the following error (nearly a typo error) when trying to compile 
2.6.0-test5/-mm2 with CONFIG_NETFILTER_ENABLE defined.

  LD      drivers/built-in.o
  CC      net/ipv4/ip_input.o
net/ipv4/ip_input.c: In function `ip_local_deliver_finish':
net/ipv4/ip_input.c:204: invalid suffix on integer constant
net/ipv4/ip_input.c:204: parse error before numeric constant
make[2]: *** [net/ipv4/ip_input.o] Error 1
make[1]: *** [net/ipv4] Error 2
make: *** [net] Error 2


 198 static inline int ip_local_deliver_finish(struct sk_buff *skb)
    199 {
    200         int ihl = skb->nh.iph->ihl*4;
    201
    202 #ifdef CONFIG_NETFILTER_DEBUG
    203         nf_debug_ip_local_deliver(skb);
    204         skb->nf_debug =3D 0;
    205 #endif /*CONFIG_NETFILTER_DEBUG*/
    206

Regards
Rémi

