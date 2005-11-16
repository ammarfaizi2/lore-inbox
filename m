Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030452AbVKPW3N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030452AbVKPW3N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 17:29:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030526AbVKPW3N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 17:29:13 -0500
Received: from ihemail1.lucent.com ([192.11.222.161]:11002 "EHLO
	ihemail1.lucent.com") by vger.kernel.org with ESMTP
	id S1030452AbVKPW3N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 17:29:13 -0500
Message-ID: <0C6AA2145B810F499C69B0947DC5078107BCDE24@oh0012exch001p.cb.lucent.com>
From: "Cipriani, Lawrence V (Larry)" <lvc@lucent.com>
To: "Cipriani, Lawrence V (Larry)" <lvc@lucent.com>,
       "'David S. Miller'" <davem@davemloft.net>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: bugs in /usr/src/linux/net/ipv6/mcast.c
Date: Wed, 16 Nov 2005 17:28:39 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Actually on this one

-------------------------------------------------

/usr/src/linux/abi/svr4/misc.c: extra semicolon near line 564:

for (p = tmp; *p; p++); 		!!!
        p--;

It's fine the way it is, it would be easier to read if was this instead

for (p = tmp; *p; p++);
p--;

but no big deal.
-----------------------------------------------------------

Larry

-----Original Message-----
From: David S. Miller [mailto:davem@davemloft.net]
Sent: Wednesday, November 16, 2005 4:02 PM
To: lvc@lucent.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: bugs in /usr/src/linux/net/ipv6/mcast.c


From: "Cipriani, Lawrence V (Larry)" <lvc@lucent.com>
Date: Wed, 16 Nov 2005 09:53:07 -0500

> /usr/src/linux/net/ipv6/mcast.c: extra semicolon near line 609         
>                 if (mc->sfmode == MCAST_INCLUDE && i >= psl->sl_count);
>                         rv = 0;                                        
> should be:
> 		    if (mc->sfmode == MCAST_EXCLUDE && i >= psl->sl_count)
> 				rv = 0;
> 
> /usr/src/linux/net/ipv6/mcast.c: extra semicolon near line 611         
>                 if (mc->sfmode == MCAST_EXCLUDE && i < psl->sl_count); 
>                         rv = 0;                             
> should be:
> 		    if (mc->sfmode == MCAST_EXCLUDE && i < psl->sl_count)
> 				rv = 0;

These have been fixed for a while now in 2.6.x
