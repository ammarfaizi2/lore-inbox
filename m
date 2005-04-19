Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261306AbVDSDYz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261306AbVDSDYz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 23:24:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261309AbVDSDYz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 23:24:55 -0400
Received: from fire.osdl.org ([65.172.181.4]:22676 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261306AbVDSDYx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 23:24:53 -0400
Date: Tue, 19 Apr 2005 13:23:59 +1000
From: Stephen Hemminger <shemminger@osdl.org>
To: Ashmi Bhanushali <ashmib@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: a networking question
Message-ID: <20050419132359.47e89b60@localhost.localdomain>
In-Reply-To: <6596a01050418003335ab6cf6@mail.gmail.com>
References: <6596a01050418003335ab6cf6@mail.gmail.com>
X-Mailer: Sylpheed-Claws 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Apr 2005 00:33:57 -0700
Ashmi Bhanushali <ashmib@gmail.com> wrote:

> hi all..
> 
> i m a new bee in lunix kernel. and i m trying to implement "FIFO+"
> queuing for packet forwarding in linux kernel by modifying the
> original code for packet forwarding(FIFO).

The more useful way to do this is to do it at the queue discipline
layer outside of IP.  Start out with sch_fifo.c and modify it for your
new algorithm.

> i m going to use fedora core 2 and the kernel version is 2.6.11-7. i
> nned some help to locate the original code of queuing (FIFO). I looked
> at some files like ip_input.c, ip_output.c and ip_forward.c in the
> net/ipv4 directory of the kernel source code. but i m not sure if
> these are the correct files to look for the original FIFO packet
> queuing implemented in linux kernel.
> 
> could someone please help me in locating the files which has the FIFO
> queuing code.
> 
> thanks in advance.
> 
> -ashmi

Networking stuff is discussed more on the netdev@oss.sgi.com list
and routing on lartc@mailman.ds9a.nl
