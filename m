Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263117AbUHXFW3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263117AbUHXFW3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 01:22:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266347AbUHXFW3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 01:22:29 -0400
Received: from relay01.kbs.net.au ([203.220.32.149]:2696 "EHLO
	relay01.kbs.net.au") by vger.kernel.org with ESMTP id S263117AbUHXFWX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 01:22:23 -0400
Subject: Re: config language shortcomings in 2.4
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Joshua Kwan <joshk@triplehelix.org>
Cc: Willy Tarreau <willy@w.ods.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <412ACC56.1020902@triplehelix.org>
References: <20040819071229.GA7598@darjeeling.triplehelix.org>
	 <20040819072826.GA16709@alpha.home.local>
	 <412ACC56.1020902@triplehelix.org>
Content-Type: text/plain
Message-Id: <1093324742.8567.38.camel@laptop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 24 Aug 2004 15:19:02 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Tue, 2004-08-24 at 15:04, Joshua Kwan wrote:
> Sorry for the belated response, but certainly it should not be necessary 
> to do:
> 
> if [ "$CONFIG_FW_LOADER" = "m" -o "$CONFIG_FW_LOADER" = "y" ]; then
> 	HAVE_SOME_FW_LOADER=y
> fi
> if [ "$CONFIG_CRC32" = "m" -o "$CONFIG_CRC32" = "m" ]; then
> 	HAVE_SOME_CRC32=y
> fi
> 
> if [ "$HAVE_SOME_CRC32" = "y" -a "$HAVE_SOME_FW_LOADER" = "y" ]; then
> 	dep_tristate 'Broadcom Tigon3 support' CONFIG_TIGON3 $CONFIG_PCI 
> $HAVE_SOME_FW_LOADER $HAVE_SOME_CRC32
> fi

Just in case someone goes to copy and paste the above, there's a typo:
CONFIG_CRC32 = m or = m.

> Anyway, it's all very disgusting and I'm inclined to just ignore it and 
> maybe some benevolent soul will one day port Kconfig back to 2.4.

Hehe. I had to do something similar when I made suspend 2 able to be
compiled as modules. It could certainly be more elegant.

Nigel
-- 
Nigel Cunningham
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

Many today claim to be tolerant. But true tolerance can cope with others
being intolerant.

