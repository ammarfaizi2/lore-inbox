Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262130AbTDAHsd>; Tue, 1 Apr 2003 02:48:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262132AbTDAHsd>; Tue, 1 Apr 2003 02:48:33 -0500
Received: from modemcable226.131-200-24.mtl.mc.videotron.ca ([24.200.131.226]:13308
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S262130AbTDAHsd>; Tue, 1 Apr 2003 02:48:33 -0500
Date: Tue, 1 Apr 2003 02:55:33 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org, "" <gibbs@scsiguy.com>
Subject: Re: aic7(censored) use after free in 2.5.66
In-Reply-To: <20030331235205.3d4d8f9f.akpm@digeo.com>
Message-ID: <Pine.LNX.4.50.0304010249320.8773-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.50.0304010141200.8773-100000@montezuma.mastecende.com>
 <Pine.LNX.4.50.0304010155470.8773-100000@montezuma.mastecende.com>
 <20030331232227.3f9c9c5f.akpm@digeo.com> <Pine.LNX.4.50.0304010236270.8773-100000@montezuma.mastecende.com>
 <20030331235205.3d4d8f9f.akpm@digeo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Mar 2003, Andrew Morton wrote:

> OK, so that's a spin_unlock(&timer->lock) in the timer code itself.  Your
> patch will fix that up.
> 
> We just need to be sure that the del_timer_sync() is not called while holding
> any locks which would prevent the timer handler from completing.  

Quick audit says we should be ok. I can do a few simple tests on this.

-- 
function.linuxpower.ca
