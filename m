Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278639AbRKGJqD>; Wed, 7 Nov 2001 04:46:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279553AbRKGJpy>; Wed, 7 Nov 2001 04:45:54 -0500
Received: from WYPP-p-144-134-137-121.prem.tmns.net.au ([144.134.137.121]:1540
	"EHLO mail.bigpond.com") by vger.kernel.org with ESMTP
	id <S278639AbRKGJpt>; Wed, 7 Nov 2001 04:45:49 -0500
Date: Wed, 7 Nov 2001 15:44:14 +1030
From: Richard <richard.how@bigpond.com>
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.4.14 link error
Message-ID: <20011107154414.A809@Gromit>
Reply-To: richard.how@bigpond.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is my first nervous attempt at kernel stuff (sweat, panic...)

Kernel 2.4.14 does not link if loopback device is enabled. The link fails
with unresolved extern reference "deactivate_page" in block.o

This function is called from drivers/block/loop.c and is located in
in mm/swap.c for kernel 2.4.13 but not for 2.4.14.
I made a copy of loop.c commented out the references (2) to deactivate_page
and compiled as a module, which seems to work just fine.

Hope this helps

