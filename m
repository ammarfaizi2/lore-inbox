Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129186AbQKPFGH>; Thu, 16 Nov 2000 00:06:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129380AbQKPFF5>; Thu, 16 Nov 2000 00:05:57 -0500
Received: from deliverator.sgi.com ([204.94.214.10]:16675 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S129186AbQKPFFp>; Thu, 16 Nov 2000 00:05:45 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: jamagallon@able.es
cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: net mods installed under misc in 2.2.18-pre21 
In-Reply-To: Your message of "Wed, 15 Nov 2000 11:52:50 BST."
             <20001115115250.A1231@werewolf.able.es> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 16 Nov 2000 15:35:34 +1100
Message-ID: <7677.974349334@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Nov 2000 11:52:50 +0100, 
"J . A . Magallon" <jamagallon@able.es> wrote:
>I have noticed that some kernel modules are installed under
>/lib/modules/XXX/misc,
>instead of /net. I have been checking the drivers/net/Makefile (little knowledge

Known problem.  Fixed with a new make modules_install algorithm in 2.4
kernels.  Back porting that change to 2.2 would force all 2.2 users to
upgrade to modutils 2.3.  AC does not want forced user space upgrades
in the stable kernel (and I agree).  So you are stuck with the broken
modutles install.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
