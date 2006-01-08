Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161168AbWAHIak@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161168AbWAHIak (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 03:30:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161166AbWAHIak
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 03:30:40 -0500
Received: from ozlabs.org ([203.10.76.45]:60650 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1161168AbWAHIaj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 03:30:39 -0500
Date: Sun, 8 Jan 2006 19:23:01 +1100
From: Anton Blanchard <anton@samba.org>
To: Andrew Morton <akpm@osdl.org>
Cc: jes@trained-monkey.org, rmk+lkml@arm.linux.org.uk, ak@suse.de,
       linux-kernel@vger.kernel.org, hch@infradead.org, torvalds@osdl.org,
       viro@ftp.linux.org.uk, linuxppc64-dev@ozlabs.org, mingo@elte.hu,
       nico@cam.org, oleg@tv-sign.ru, alan@lxorguk.ukuu.org.uk,
       arjan@infradead.org
Subject: Re: PowerPC fastpaths for mutex subsystem
Message-ID: <20060108082301.GN26499@krispykreme>
References: <43BC5E15.207@austin.ibm.com> <20060105143502.GA16816@elte.hu> <43BD4C66.60001@austin.ibm.com> <20060105222106.GA26474@elte.hu> <43BDA672.4090704@austin.ibm.com> <20060106002919.GA29190@pb15.lixom.net> <43BFFF1D.7030007@austin.ibm.com> <20060107143722.25afd85d.akpm@osdl.org> <20060108074356.GM26499@krispykreme> <20060108000021.588c6f5f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060108000021.588c6f5f.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> What's "unfair"?  Mutexes are FIFO, as are x86 semaphores.

The ppc64 semaphores dont force everyone into the slow path under
contention. So you could drop and pick up the semaphore even with
someone waiting. I thought thats how the new mutex code worked.

Anton
