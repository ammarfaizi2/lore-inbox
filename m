Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264604AbUAAWOw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 17:14:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264902AbUAAWMg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 17:12:36 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:39090 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S264599AbUAAWIF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 17:08:05 -0500
Subject: Re: swapper: page allocation failure. order:3, mode:0x20
From: Christophe Saout <christophe@saout.de>
To: Anton Blanchard <anton@samba.org>
Cc: Andrew Morton <akpm@osdl.org>, joneskoo@derbian.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040101130147.GM28023@krispykreme>
References: <20040101093553.GA24788@derbian.org>
	 <20040101101541.GJ28023@krispykreme>
	 <20040101022553.2be5f043.akpm@osdl.org>
	 <20040101130147.GM28023@krispykreme>
Content-Type: text/plain
Message-Id: <1072994888.6532.3.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 01 Jan 2004 23:08:09 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Do, den 01.01.2004 schrieb Anton Blanchard um 14:01:

> How does this look?
> [...]
> +	static unsigned long toks = 10*5*HZ;
> +	static unsigned long last_msg; 
> +	static int missed;

This would mean that all users of printk_ratelimit share this. If
printk_ratelimit is bombed by one user other perhaps important messages
are also suppressed.


