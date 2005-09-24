Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932226AbVIXSra@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226AbVIXSra (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Sep 2005 14:47:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932229AbVIXSr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Sep 2005 14:47:29 -0400
Received: from relay01.mail-hub.dodo.com.au ([203.220.32.149]:6802 "EHLO
	relay01.mail-hub.dodo.com.au") by vger.kernel.org with ESMTP
	id S932226AbVIXSr3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Sep 2005 14:47:29 -0400
From: Grant Coady <grant_lkml@dodo.com.au>
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: Simon Evans <spse@secret.org.uk>, Vojtech Pavlik <vojtech@suse.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: New inventions in rounding up in catc.c?
Date: Sun, 25 Sep 2005 04:46:23 +1000
Organization: http://bugsplatter.mine.nu/
Message-ID: <l27bj1hjeqsl9ifg4ogb0drj56fsm0j62a@4ax.com>
References: <200509241343.42464.vda@ilport.com.ua>
In-Reply-To: <200509241343.42464.vda@ilport.com.ua>
X-Mailer: Forte Agent 2.0/32.652
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Sep 2005 13:43:42 +0300, Denis Vlasenko <vda@ilport.com.ua> wrote:
> 		/* F5U011 only does one packet per RX */
> 		if (catc->is_f5u011)
> 			break;
>-		pkt_start += (((pkt_len + 1) >> 6) + 1) << 6;
>+		pkt_start += ((pkt_len + 2) + 63) & ~63;

  		pkt_start += ((pkt_len + 1) + 64) & ~63;

Seems more clear to me.

Grant.

