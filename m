Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261189AbUKHTYq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261189AbUKHTYq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 14:24:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261220AbUKHTXn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 14:23:43 -0500
Received: from cantor.suse.de ([195.135.220.2]:17857 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261189AbUKHTVR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 14:21:17 -0500
Date: Mon, 8 Nov 2004 20:01:30 +0100
From: Andi Kleen <ak@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] kill IN_STRING_C
Message-ID: <20041108190130.GA2564@wotan.suse.de>
References: <20041107142445.GH14308@stusta.de> <20041108134448.GA2456@wotan.suse.de> <20041108153436.GB9783@stusta.de> <20041108161935.GC2456@wotan.suse.de> <20041108163101.GA13234@stusta.de> <20041108175120.GB27525@wotan.suse.de> <20041108183449.GC15077@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041108183449.GC15077@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 08, 2004 at 07:34:49PM +0100, Adrian Bunk wrote:
> On Mon, Nov 08, 2004 at 06:51:20PM +0100, Andi Kleen wrote:
> > On Mon, Nov 08, 2004 at 05:31:01PM +0100, Adrian Bunk wrote:
> > > On Mon, Nov 08, 2004 at 05:19:35PM +0100, Andi Kleen wrote:
> > > > > Rethinking it, I don't even understand the sprintf example in your 
> > > > > changelog entry - shouldn't an inclusion of kernel.h always get it 
> > > > > right?
> > > > 
> > > > Newer gcc rewrites sprintf(buf,"%s",str) to strcpy(buf,str) transparently.
> > > 
> > > Which gcc is "Newer"?
> > 
> > I saw it with 3.3-hammer, which had additional optimizations in this 
> > area at some point. Note that 3.3-hammer is widely used. I don't 
> > know if 3.4 does it in the same way.
> 
> Is this a -hammer specific problem?

No, I just checked a 4.0 mainline gcc and it does it too.

Note I saw it on x86-64, don't know if it occurs on i386 too.

-Andi
