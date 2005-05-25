Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261480AbVEYRG1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261480AbVEYRG1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 13:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261482AbVEYRG1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 13:06:27 -0400
Received: from dns.toxicfilms.tv ([150.254.220.184]:58302 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP id S261480AbVEYRGR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 13:06:17 -0400
Date: Wed, 25 May 2005 19:06:18 +0200
From: Maciej Soltysiak <solt2@dns.toxicfilms.tv>
X-Mailer: The Bat! (v3.0) UNREG / CD5BF9353B3B7091
Reply-To: Maciej Soltysiak <solt2@dns.toxicfilms.tv>
X-Priority: 3 (Normal)
Message-ID: <849865860.20050525190618@dns.toxicfilms.tv>
To: linux-kernel@vger.kernel.org
CC: Stephen Hemminger <shemminger@osdl.org> (Open Source Development
	Lab)
Subject: Re: 2.6.12-rc4-tcp3
In-Reply-To: <20050524163939.0fb86509@dxpl.pdx.osdl.net>
References: <20050524163939.0fb86509@dxpl.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

It is a pity it does not apply to -rc5:
Gives this reject:

***************
*** 4355,4370 ****
                                        goto no_ack;
                        }

-                       if (eaten) {
-                               if (tcp_in_quickack_mode(tp)) {
-                                       tcp_send_ack(sk);
-                               } else {
-                                       tcp_send_delayed_ack(sk);
-                               }
-                       } else {
-                               __tcp_ack_snd_check(sk, 0);
-                       }
-
  no_ack:
                        if (eaten)
                                __kfree_skb(skb);
--- 3719,3725 ----
                                        goto no_ack;
                        }

+                       __tcp_ack_snd_check(sk, 0);
  no_ack:
                        if (eaten)
                                __kfree_skb(skb);

Regards,
Maciej


