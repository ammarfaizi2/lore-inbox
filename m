Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751365AbWHCUuh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751365AbWHCUuh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 16:50:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751376AbWHCUuh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 16:50:37 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:45790 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751365AbWHCUug (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 16:50:36 -0400
Subject: Re: [PATCH] eicon: fix define conflict with ptrace
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Armin Schindler <mac@melware.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060803203411.GB6828@martell.zuzino.mipt.ru>
References: <20060803203411.GB6828@martell.zuzino.mipt.ru>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 03 Aug 2006 22:09:59 +0100
Message-Id: <1154639399.23655.129.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-08-04 am 00:34 +0400, ysgrifennodd Alexey Dobriyan:
> * MODE_MASK is unused in eicon driver.
> * Conflicts with a ptrace stuff on arm.
> 
> drivers/isdn/hardware/eicon/divasync.h:259:1: warning: "MODE_MASK" redefined
> include2/asm/ptrace.h:48:1: warning: this is the location of the previous definition
> 
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>

NAK. You need to fix all the code expecting to use the MODE_MASK with a
value of 0x00000080

