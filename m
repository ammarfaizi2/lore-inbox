Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261907AbSKHNZH>; Fri, 8 Nov 2002 08:25:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261908AbSKHNZH>; Fri, 8 Nov 2002 08:25:07 -0500
Received: from sex.inr.ac.ru ([193.233.7.165]:55963 "HELO sex.inr.ac.ru")
	by vger.kernel.org with SMTP id <S261907AbSKHNZG>;
	Fri, 8 Nov 2002 08:25:06 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200211081331.QAA12531@sex.inr.ac.ru>
Subject: Re: [documentation] Re: [LARTC] IPSEC FIRST LIGHT! (by non-kernel developer :-))
To: ahu@ds9a.nl (bert hubert)
Date: Fri, 8 Nov 2002 16:31:29 +0300 (MSK)
Cc: davem@redhat.com, mdiehl@dominion.dyndns.org, linux-kernel@vger.kernel.org,
       gem@asplinux.ru
In-Reply-To: <20021108122523.GA21075@outpost.ds9a.nl> from "bert hubert" at Nov 8, 2 01:25:23 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Kernel enters a very tight loop here, I'm amazed that magic sysrq still
> works, how is that?

Yes, this is sort of inefficient loop. :-)


===== net/ipv4/xfrm_policy.c 1.8 vs edited =====
--- 1.8/net/ipv4/xfrm_policy.c	Fri Nov  8 16:25:06 2002
+++ edited/net/ipv4/xfrm_policy.c	Fri Nov  8 16:27:43 2002
@@ -948,6 +948,7 @@
 			dst_release(dst);
 			return NULL;
 		}
+		child = child->child;
 	}
 
 	return dst;


Alexey
