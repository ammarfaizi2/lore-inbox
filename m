Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271173AbTGPWRM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 18:17:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271167AbTGPWO4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 18:14:56 -0400
Received: from fw.osdl.org ([65.172.181.6]:16554 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271163AbTGPWON (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 18:14:13 -0400
Date: Wed, 16 Jul 2003 15:21:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] print_dev_t for 2.6.0-test1-mm
Message-Id: <20030716152143.6ab7d7d3.akpm@osdl.org>
In-Reply-To: <20030716222015.GB1964@win.tue.nl>
References: <20030716184609.GA1913@kroah.com>
	<20030716130915.035a13ca.akpm@osdl.org>
	<20030716210253.GD2279@kroah.com>
	<20030716141320.5bd2a8b3.akpm@osdl.org>
	<20030716213451.GA1964@win.tue.nl>
	<20030716143902.4b26be70.akpm@osdl.org>
	<20030716222015.GB1964@win.tue.nl>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer <aebr@win.tue.nl> wrote:
>
> 
> > Why do we need the 16:16 option?
> 
> It is not very important, but major 0 is reserved, so if userspace
> (or a filesystem) hands us a 32-bit device number, we have to
> split that in some way, not 0+32. Life is easiest with 16+16.
> (Now the major is nonzero, otherwise we had 8+8.)
> Other choices lead to slightly more complicated code.
> 

Why would anyone hand the kernel a 32-bit device number?  They're either 16
or 64, are they not?

