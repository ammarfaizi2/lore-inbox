Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161094AbWAHIBO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161094AbWAHIBO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 03:01:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161095AbWAHIBN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 03:01:13 -0500
Received: from smtp.osdl.org ([65.172.181.4]:12451 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161094AbWAHIBL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 03:01:11 -0500
Date: Sun, 8 Jan 2006 00:00:21 -0800
From: Andrew Morton <akpm@osdl.org>
To: Anton Blanchard <anton@samba.org>
Cc: jschopp@austin.ibm.com, jes@trained-monkey.org, rmk+lkml@arm.linux.org.uk,
       hch@infradead.org, linux-kernel@vger.kernel.org, ak@suse.de,
       torvalds@osdl.org, viro@ftp.linux.org.uk, linuxppc64-dev@ozlabs.org,
       mingo@elte.hu, nico@cam.org, oleg@tv-sign.ru, alan@lxorguk.ukuu.org.uk,
       arjan@infradead.org
Subject: Re: PowerPC fastpaths for mutex subsystem
Message-Id: <20060108000021.588c6f5f.akpm@osdl.org>
In-Reply-To: <20060108074356.GM26499@krispykreme>
References: <20060104144151.GA27646@elte.hu>
	<43BC5E15.207@austin.ibm.com>
	<20060105143502.GA16816@elte.hu>
	<43BD4C66.60001@austin.ibm.com>
	<20060105222106.GA26474@elte.hu>
	<43BDA672.4090704@austin.ibm.com>
	<20060106002919.GA29190@pb15.lixom.net>
	<43BFFF1D.7030007@austin.ibm.com>
	<20060107143722.25afd85d.akpm@osdl.org>
	<20060108074356.GM26499@krispykreme>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Blanchard <anton@samba.org> wrote:
>
>  
> > Doens't this mean that the sped-up mutexes are still slower than semaphores?
> 
> Wasnt most of the x86 mutex gain a result of going from fair to unfair
> operation? The current ppc64 semaphores are unfair.
> 

What's "unfair"?  Mutexes are FIFO, as are x86 semaphores.
