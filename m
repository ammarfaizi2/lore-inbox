Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261618AbUCKSKH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 13:10:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261628AbUCKSKH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 13:10:07 -0500
Received: from fw.osdl.org ([65.172.181.6]:33513 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261618AbUCKSKD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 13:10:03 -0500
Date: Thu, 11 Mar 2004 10:09:57 -0800
From: Andrew Morton <akpm@osdl.org>
To: Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>
Cc: lkml@metanurb.dk, linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-mm1
Message-Id: <20040311100957.00dd6e7f.akpm@osdl.org>
In-Reply-To: <200403111453.20866.norberto+linux-kernel@bensa.ath.cx>
References: <20040310233140.3ce99610.akpm@osdl.org>
	<1079024816.5325.2.camel@redeeman.linux.dk>
	<200403111453.20866.norberto+linux-kernel@bensa.ath.cx>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Norberto Bensa <norberto+linux-kernel@bensa.ath.cx> wrote:
>
> Redeeman wrote:
>  > hey andrew, i have a problem with this kernel, when it boots, it lists
>  > vp_ide and stuff, and then suddenly after that my screen gets flodded
>  > with sys traces and stuff, i cant even read it, so fast they come, and
>  > the syste doesnet go further
> 
>  Same here. bad: scheduling while atomic. .config attached (no dmesg as I have 
>  no experience with serial consoles yet.)

Did you remove the spin_unlock_irq() from the end of mpage_writepages()?
