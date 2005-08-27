Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750836AbVH0X6W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750836AbVH0X6W (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Aug 2005 19:58:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750837AbVH0X6W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Aug 2005 19:58:22 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:12303 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750836AbVH0X6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Aug 2005 19:58:21 -0400
Date: Sun, 28 Aug 2005 00:58:13 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Paul Mackerras <paulus@samba.org>
Cc: torvalds@osdl.org, akpm@osdl.org, dwmw2@redhat.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove race between con_open and con_close
Message-ID: <20050828005813.A24838@flint.arm.linux.org.uk>
Mail-Followup-To: Paul Mackerras <paulus@samba.org>, torvalds@osdl.org,
	akpm@osdl.org, dwmw2@redhat.com,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
References: <17168.63953.95070.579096@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <17168.63953.95070.579096@cargo.ozlabs.ibm.com>; from paulus@samba.org on Sun, Aug 28, 2005 at 09:40:01AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 28, 2005 at 09:40:01AM +1000, Paul Mackerras wrote:
> I have a laptop (G3 powerbook) which will pretty reliably hit a race
> between con_open and con_close late in the boot process and oops in
> vt_ioctl due to tty->driver_data being NULL.

Have you looked at how serial_core handles this kind of problem in
its open and close methods?  I put some comments in there because
of the issue, after thinking about it fairly carefully.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
