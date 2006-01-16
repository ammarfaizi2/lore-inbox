Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751274AbWAPXXi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751274AbWAPXXi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 18:23:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751278AbWAPXXi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 18:23:38 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:275 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751271AbWAPXXh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 18:23:37 -0500
Date: Tue, 17 Jan 2006 00:23:32 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: sparse triggers OOM killer
Message-ID: <20060116232332.GC8752@mars.ravnborg.org>
References: <20060107111827.GA16133@mars.ravnborg.org> <Pine.LNX.4.64.0601071004130.3169@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0601071004130.3169@g5.osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus.

On Sat, Jan 07, 2006 at 10:07:10AM -0800, Linus Torvalds wrote:
> 
> 
> On Sat, 7 Jan 2006, Sam Ravnborg wrote:
> > 
> > There was no oops or similar and sparse just exited after a while with
> > an errorcode (137).
> 
> That's just SIGKILL (128+9). Which is normal for the OOM killer.
> 
> > Now I wonder if I have hit a bug in sparse or this is what I should
> > expect.
> 
> Well, sparse does keep a _lot_ of stuff in memory, and the "do many files 
> at once" will basically keep every single one (with full types, full 
> linearization etc) in memory at the same time.
> 
> It's probably fairly easy to fix: I should just make sparse release all 
> the linearizations and symbols when they go out of file scope.
> 
> The "do many files at once" thing really was just a quick hack, so the 
> lack of memory release is not that susprising.
> 
> I'll see what I can do.

Any news on this (call this a polite remineder)?
I have not tried to dig into it myself - assuming that it will take me
considerably time to do right..

	Sam
