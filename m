Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261434AbTIOOho (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 10:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261436AbTIOOho
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 10:37:44 -0400
Received: from sampa7.prodam.sp.gov.br ([200.230.190.107]:14094 "EHLO
	sampa7.prodam.sp.gov.br") by vger.kernel.org with ESMTP
	id S261434AbTIOOhn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 10:37:43 -0400
Subject: Re: 2.6.0-test5-mm2
From: Luiz Capitulino <lcapitulino@prefeitura.sp.gov.br>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, rusty@rustcorp.com.au
In-Reply-To: <20030914234843.20cea5b3.akpm@osdl.org>
References: <20030914234843.20cea5b3.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Organization: Governo Eletronico - SP
Message-Id: <1063636490.5588.10.camel@lorien>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Mon, 15 Sep 2003 11:34:51 -0300
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Seg, 2003-09-15 às 03:48, Andrew Morton escreveu:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test5/2.6.0-test5-mm2/

net/ipv4/ip_input.c: In function `ip_local_deliver_finish':
net/ipv4/ip_input.c:204: invalid suffix on integer constant
net/ipv4/ip_input.c:204: syntax error before numeric constant
make[2]: ** [net/ipv4/ip_input.o] Error 1
make[1]: ** [net/ipv4] Error 2
make: ** [net] Error 2

 this happens when CONFIG_NETFILTER_DEBUG is set. The line with
the problem are here:

#ifdef CONFIG_NETFILTER_DEBUG
        nf_debug_ip_local_deliver(skb);
        skb->nf_debug =3D 0;
#endif /*CONFIG_NETFILTER_DEBUG*/

 in the skb->nf_debug.

-- 
Luiz Fernando N. Capitulino

<lcapitulino@prefeitura.sp.gov.br>
<http://www.telecentros.sp.gov.br>

