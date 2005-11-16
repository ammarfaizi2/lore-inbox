Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030359AbVKPOxO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030359AbVKPOxO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 09:53:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030360AbVKPOxO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 09:53:14 -0500
Received: from ihemail1.lucent.com ([192.11.222.161]:394 "EHLO
	ihemail1.lucent.com") by vger.kernel.org with ESMTP
	id S1030359AbVKPOxO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 09:53:14 -0500
Message-ID: <0C6AA2145B810F499C69B0947DC5078107BCDB0C@oh0012exch001p.cb.lucent.com>
From: "Cipriani, Lawrence V (Larry)" <lvc@lucent.com>
To: linux-kernel@vger.kernel.org
Subject: bugs in /usr/src/linux/net/ipv6/mcast.c
Date: Wed, 16 Nov 2005 09:53:07 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


/usr/src/linux/net/ipv6/mcast.c: extra semicolon near line 609         
                if (mc->sfmode == MCAST_INCLUDE && i >= psl->sl_count);
                        rv = 0;                                        
should be:
		    if (mc->sfmode == MCAST_EXCLUDE && i >= psl->sl_count)
				rv = 0;

/usr/src/linux/net/ipv6/mcast.c: extra semicolon near line 611         
                if (mc->sfmode == MCAST_EXCLUDE && i < psl->sl_count); 
                        rv = 0;                             
should be:
		    if (mc->sfmode == MCAST_EXCLUDE && i < psl->sl_count)
				rv = 0;

