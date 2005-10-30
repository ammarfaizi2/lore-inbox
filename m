Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932224AbVJ3TMq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224AbVJ3TMq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 14:12:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932226AbVJ3TMq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 14:12:46 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:40935 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932224AbVJ3TMp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 14:12:45 -0500
Subject: Re: select() for delay.
From: Arjan van de Ven <arjan@infradead.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: madhu.subbaiah@wipro.com, linux-kernel@vger.kernel.org
In-Reply-To: <200510302006.15892.arnd@arndb.de>
References: <EE111F112BBFF24FB11DB557FA2E5BF301992F02@BLR-EC-MBX02.wipro.com>
	 <200510302006.15892.arnd@arndb.de>
Content-Type: text/plain
Date: Sun, 30 Oct 2005 20:12:29 +0100
Message-Id: <1130699550.2829.8.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.9 (++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (2.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-10-30 at 20:06 +0100, Arnd Bergmann wrote:
> On Maandag 24 Oktober 2005 12:55, madhu.subbaiah@wipro.com wrote:
>  
> > This is regarding select() system call.
> > 
> > Linux select() man page mentions " Some  code  calls  select with all
> > three sets empty, n zero, and a non-null timeout as a fairly portable
> > way to sleep  with  subsecond  precision".
> 
> When you make a change to a system call, you should always check
> if the change makes sense for the 32 bit emulation path as well.
> 
> In this case, you should definitely do the same thing to both
> sys_select and compat_sys_select if this is found worthwhile.
>  
> > This patch improves the sys_select() execution when used for delay. 
> 
> Please describe what aspect of the syscall is improved. Is this only
> speeding up the execution for the delay case while slowing down
> the normal case, or do the actual semantics improve?

there is something funky about increasing the speed of a delay ;)

