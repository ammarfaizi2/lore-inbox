Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751092AbVKNLyZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751092AbVKNLyZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 06:54:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751094AbVKNLyZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 06:54:25 -0500
Received: from perninha.conectiva.com.br ([200.140.247.100]:64716 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S1751092AbVKNLyY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 06:54:24 -0500
Date: Mon, 14 Nov 2005 09:54:22 -0200
From: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>
To: akpm <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, netdev@oss.sgi.com
Subject: [PATCH] - Fixes sparse warning in ipv6/ipv6_sockglue.c
Message-Id: <20051114095422.5cc4727f.lcapitulino@mandriva.com.br>
Organization: Mandriva
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i386-conectiva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The patch below fixes the following sparse warning:

net/ipv6/ipv6_sockglue.c:291:13: warning: Using plain integer as NULL pointer

Signed-off-by: Luiz Capitulino <lcapitulino@mandriva.com.br>

 net/ipv6/ipv6_sockglue.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -287,7 +287,7 @@ int ipv6_setsockopt(struct sock *sk, int
 	{
 		struct ipv6_txoptions *opt;
 		if (optlen == 0)
-			optval = 0;
+			optval = NULL;
 
 		/* hop-by-hop / destination options are privileged option */
 		retv = -EPERM;


-- 
Luiz Fernando N. Capitulino
