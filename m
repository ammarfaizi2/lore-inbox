Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261960AbTEFVeU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 17:34:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261965AbTEFVeU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 17:34:20 -0400
Received: from zero.aec.at ([193.170.194.10]:46348 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S261960AbTEFVeT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 17:34:19 -0400
Date: Tue, 6 May 2003 23:45:38 +0200
From: Andi Kleen <ak@muc.de>
To: Andrew Morton <akpm@digeo.com>
Cc: Andi Kleen <ak@muc.de>, bunk@fs.tum.de, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix .altinstructions linking failures
Message-ID: <20030506214538.GA18532@averell>
References: <20030506063055.GA15424@averell> <20030506164441.GO9794@fs.tum.de> <20030506195614.GA23831@averell> <20030506210831.GA18315@averell> <20030506142551.1f5619d6.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030506142551.1f5619d6.akpm@digeo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 06, 2003 at 11:25:51PM +0200, Andrew Morton wrote:
> Andi Kleen <ak@muc.de> wrote:
> >
> > On Tue, May 06, 2003 at 09:56:14PM +0200, Andi Kleen wrote:
> > > The driver is buggy. The #ifdef MODULE needs to be removed and proc_cpia_destroy 
> > > be marked __exit instead, then things will be ok.
> > 
> > FWIW I compiled a "maxi kernel" now (with everything that compiles compiled in) 
> > and only cpia seems to have this bug. So with this patch things should be ok
> > again.
> 
> Where should we be discarding .exit.data?  link-time or runtime?

Run time is probably safer.

-Andi
