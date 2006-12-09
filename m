Return-Path: <linux-kernel-owner+w=401wt.eu-S1758762AbWLIV66@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758762AbWLIV66 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 16:58:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758637AbWLIV65
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 16:58:57 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:33710
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1758519AbWLIV65 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 16:58:57 -0500
Date: Sat, 09 Dec 2006 13:58:57 -0800 (PST)
Message-Id: <20061209.135857.18290043.davem@davemloft.net>
To: randy.dunlap@oracle.com
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, khc@pm.waw.pl
Subject: Re: [PATCH] fix WAN routers kconfig dependency
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061209124108.a25bb375.randy.dunlap@oracle.com>
References: <20061209124108.a25bb375.randy.dunlap@oracle.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <randy.dunlap@oracle.com>
Date: Sat, 9 Dec 2006 12:41:08 -0800

> From: Randy Dunlap <randy.dunlap@oracle.com>
> 
> Currently WAN router drivers can be built in-kernel while the
> register/unregister_wan_device interfaces are built as modules.
> This causes:
> 
> drivers/built-in.o: In function `cycx_init':
> cycx_main.c:(.init.text+0x5c4b): undefined reference to `register_wan_device'
> drivers/built-in.o: In function `cycx_exit':
> cycx_main.c:(.exit.text+0x560): undefined reference to `unregister_wan_device'
> make: *** [.tmp_vmlinux1] Error 1
> 
> The problem is caused by tristate -> bool conversion (y or m => y),
> so convert WAN_ROUTER_DRIVERS to a tristate so that the correct
> dependency is preserved.
> 
> Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>

Applied, thanks Randy.
