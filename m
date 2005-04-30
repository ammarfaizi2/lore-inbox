Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261251AbVD3QXx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261251AbVD3QXx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 12:23:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261278AbVD3QXx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 12:23:53 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:49605 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S261251AbVD3QXw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 12:23:52 -0400
Date: Sat, 30 Apr 2005 18:20:54 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: "Pedro Venda (SYSADM)" <pjvenda@rnl.ist.utl.pt>
Cc: linux-kernel@vger.kernel.org, rnl@rnl.ist.utl.pt
Subject: Re: ftp server crashes on heavy load: possible scheduler bug
Message-ID: <20050430162054.GA20899@electric-eye.fr.zoreil.com>
References: <200504261402.57375.pjvenda@rnl.ist.utl.pt> <20050427181609.GA21785@electric-eye.fr.zoreil.com> <200504291519.52558.pjvenda@rnl.ist.utl.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200504291519.52558.pjvenda@rnl.ist.utl.pt>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pedro Venda (SYSADM) <pjvenda@rnl.ist.utl.pt> :
[...]
> please note that netconsole was added AFTER some crashes to analise the crash 
> dump, so I don't think it's directly related.

I agree. See it more as 1) preempt is "interesting", 2) it is not clear that
netpoll will show what one expects when networking issues come into play
(netpoll locking had to change recently). It would be nice to narrow the
issue within the fs/block subsystem.

> keep in mind that this is a production machine.

Some may toast me but I'd avoid preempt on a production machine.

--
Ueimor
