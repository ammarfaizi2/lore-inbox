Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262353AbTJ3LDY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 06:03:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262355AbTJ3LDY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 06:03:24 -0500
Received: from fire.yars.free.net ([193.233.48.99]:10112 "EHLO
	fire.yars.free.net") by vger.kernel.org with ESMTP id S262353AbTJ3LDX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 06:03:23 -0500
Date: Thu, 30 Oct 2003 14:02:59 +0300
From: "Alexander V. Lukyanov" <lav@netis.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: 2.6.0-test9: access beyond end of device
Message-ID: <20031030110258.GA13681@night.netis.priv>
References: <20031029101240.GA12958@night.netis.priv> <20031029124003.4510bb1d.akpm@osdl.org> <20031030092248.GA7649@swing.yars.free.net> <20031030013904.6acaefe3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031030013904.6acaefe3.akpm@osdl.org>
User-Agent: Mutt/1.4i
X-NETIS-MailScanner-Information: Please contact NETIS Telecom for more information (+7 0852 797709)
X-NETIS-MailScanner: Found to be clean
X-NETIS-MailScanner-SpamCheck: not spam, SpamAssassin (score=-7.1,
	required 5, AWL 0.00, BAYES_20 -2.60, EMAIL_ATTRIBUTION -0.50,
	IN_REP_TO -0.37, REFERENCES -0.00, REPLY_WITH_QUOTES 0.00,
	USER_AGENT_MUTT -2.80)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 30, 2003 at 01:39:04AM -0800, Andrew Morton wrote:
> Congratulations, you broke the 2.6 networking code!

Probably not. I have found a problem in ip_wccp module which I have loaded.
It used ip_rcv while netif_rx is the proper function to use.

After I have fixed that, linux-2.6.0-test9 works well. Sorry for confusion.
I'll report if I find other problems. Thanks!

-- 
   Alexander.
