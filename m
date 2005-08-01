Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261282AbVHAVSv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261282AbVHAVSv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 17:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261258AbVHAVRD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 17:17:03 -0400
Received: from graphe.net ([209.204.138.32]:3529 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S261289AbVHAVQt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 17:16:49 -0400
Date: Mon, 1 Aug 2005 14:16:44 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Richard Purdie <rpurdie@rpsys.net>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3-mm3
In-Reply-To: <1122930474.7648.119.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.62.0508011414480.7574@graphe.net>
References: <20050728025840.0596b9cb.akpm@osdl.org> 
 <1122860603.7626.32.camel@localhost.localdomain>  <Pine.LNX.4.62.0508010908530.3546@graphe.net>
  <1122926537.7648.105.camel@localhost.localdomain> 
 <Pine.LNX.4.62.0508011335090.7011@graphe.net> <1122930474.7648.119.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Aug 2005, Richard Purdie wrote:

> On Mon, 2005-08-01 at 13:36 -0700, Christoph Lameter wrote:
> > Could you get me some more information about the hang? A stacktrace would 
> > be useful.
> 
> I've attached gdb to it and its stuck in memcpy (from glibc). The rest
> of the trace is junk as glibc's arm memcpy implementation will have
> destroyed the frame pointer. The current instruction is a store to
> memory (stmneia r0!, {r3,r4} ) and the instruction pointer isn't
> changing...

IP Not changing? Could it be in a loop doing faults for the same memory 
location that you cannot observe with gdb? Or is there some hardware fault 
that has stopped the processor?
