Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261699AbUKXCNj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261699AbUKXCNj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 21:13:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261688AbUKXCNV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 21:13:21 -0500
Received: from fw.osdl.org ([65.172.181.6]:61581 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261684AbUKXCK6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 21:10:58 -0500
Date: Tue, 23 Nov 2004 18:09:31 -0800
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: chas@cmf.nrl.navy.mil, linux-atm-general@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, jgarzik@pobox.com,
       linux-net@vger.kernel.org
Subject: Re: [2.6 patch] small drivers/atm cleanups (fwd)
Message-Id: <20041123180931.36f1a733.akpm@osdl.org>
In-Reply-To: <20041124020411.GL2927@stusta.de>
References: <20041124020411.GL2927@stusta.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:
>
>   /*
>  - * This routine will clock the Read_Status_reg function into the X2520
>  - * eeprom, then pull the result from bit 16 of the NicSTaR's General Purpose 
>  - * register.  
>  - */
>  -
>  -u_int32_t
>  -nicstar_read_eprom_status( virt_addr_t base )

I'd be inclined to whack an #if 0 around functions such as this rather than
removing them.  Someone may come along one day and do some work on the
driver, and nicstar_read_eprom_status() may prove to be useful to them.

Nobody would ever thing to go trolling back through the revision history
looking to see if previously-interesting stuff was deleted.


