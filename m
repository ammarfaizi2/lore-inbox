Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263773AbTKKWdZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 17:33:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263806AbTKKWdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 17:33:24 -0500
Received: from modemcable137.219-201-24.mc.videotron.ca ([24.201.219.137]:57986
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S263773AbTKKWdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 17:33:20 -0500
Date: Tue, 11 Nov 2003 17:32:26 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: Anton Blanchard <anton@samba.org>, Linus Torvalds <torvalds@osdl.org>,
       Erik Jacobson <erikj@subway.americas.sgi.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6 /proc/interrupts fails on systems with many CPUs
In-Reply-To: <31250000.1068590491@flay>
Message-ID: <Pine.LNX.4.53.0311111724380.8688@montezuma.fsmlabs.com>
References: <9710000.1068573723@flay> <Pine.LNX.4.44.0311111019210.30657-100000@home.osdl.org>
 <20031111201458.GS930@krispykreme> <31250000.1068590491@flay>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Nov 2003, Martin J. Bligh wrote:

> That seems particularly .... odd ... as PAGE_SIZE isn't anywhere near the
> breakpoint. Worst case (and I know I'll get yelled at for this, but I'll
> get another amusing analogy out of Linus ;-)) we should just call kmalloc
> and if it fails, then try vmalloc ...

You're Cruisin' for a bruisin' ;)

I wonder if it ever does exceed 128k anyway...

static int semctl_main(...)
{
	int nsems = sma->sem_nsems;
	...
	sem_io = ipc_alloc(sizeof(ushort)*nsems);
	...
}
