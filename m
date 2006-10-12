Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750811AbWJLS3o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811AbWJLS3o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 14:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750967AbWJLS3o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 14:29:44 -0400
Received: from smtp.osdl.org ([65.172.181.4]:55260 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750806AbWJLS3n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 14:29:43 -0400
Date: Thu, 12 Oct 2006 11:29:38 -0700
From: Andrew Morton <akpm@osdl.org>
To: Helge Hafting <helge.hafting@aitel.hist.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc1-mm1 - locks when using "dd bs=1M" from card reader
Message-Id: <20061012112938.97ef924c.akpm@osdl.org>
In-Reply-To: <452E327C.9020707@aitel.hist.no>
References: <20061010000928.9d2d519a.akpm@osdl.org>
	<452E327C.9020707@aitel.hist.no>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Oct 2006 14:18:04 +0200
Helge Hafting <helge.hafting@aitel.hist.no> wrote:

> I found an easy way to hang the kernel when copying a SD-card:
> 
> dd if=/dev/sdc of=file bs=1048576
> 
> I.e. copy the entire 256MB card in 1MB chunks.  I got about
> 160MB before the kernel hung.  Not even sysrq+B worked, I needed
> the reset button.  The pc has a total of 512MB memory if that matters.
> 
> Using bs=4096 instead let me copy the entire card with no problems,
> but that seems to progress slower.
> 
> The above 'dd' command hangs my office pc every time. So I can repeat
> it for debugging purposes. 
> 

What device driver is providing /dev/sdc?

Did any previous kernels work correctly?  If so, which?
