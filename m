Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261272AbVHAVai@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261272AbVHAVai (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 17:30:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261289AbVHAV2n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 17:28:43 -0400
Received: from tim.rpsys.net ([194.106.48.114]:49294 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S261272AbVHAV1a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 17:27:30 -0400
Subject: Re: 2.6.13-rc3-mm3
From: Richard Purdie <rpurdie@rpsys.net>
To: Christoph Lameter <christoph@lameter.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.62.0508011414480.7574@graphe.net>
References: <20050728025840.0596b9cb.akpm@osdl.org>
	 <1122860603.7626.32.camel@localhost.localdomain>
	 <Pine.LNX.4.62.0508010908530.3546@graphe.net>
	 <1122926537.7648.105.camel@localhost.localdomain>
	 <Pine.LNX.4.62.0508011335090.7011@graphe.net>
	 <1122930474.7648.119.camel@localhost.localdomain>
	 <Pine.LNX.4.62.0508011414480.7574@graphe.net>
Content-Type: text/plain
Date: Mon, 01 Aug 2005 22:27:17 +0100
Message-Id: <1122931637.7648.125.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-08-01 at 14:16 -0700, Christoph Lameter wrote:
> On Mon, 1 Aug 2005, Richard Purdie wrote:
> > I've attached gdb to it and its stuck in memcpy (from glibc). The rest
> > of the trace is junk as glibc's arm memcpy implementation will have
> > destroyed the frame pointer. The current instruction is a store to
> > memory (stmneia r0!, {r3,r4} ) and the instruction pointer isn't
> > changing...
> 
> IP Not changing? Could it be in a loop doing faults for the same memory 
> location that you cannot observe with gdb? Or is there some hardware fault 
> that has stopped the processor?

I'm not the worlds most experienced user of gdb but I can't see any
evidence of a hardware fault and the processor shows all indications of
running. It seems likely to be looping with memory faults or otherwise
jammed somehow.

Is there anything I can use in /proc to monitor page faults or anything
I can do with gdb to help narrow this down?

Richard



