Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270328AbTHLOIG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 10:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270352AbTHLOIG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 10:08:06 -0400
Received: from pwmail.procempa.com.br ([200.248.222.108]:52960 "EHLO
	portoweb.com.br") by vger.kernel.org with ESMTP id S270328AbTHLOID
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 10:08:03 -0400
Date: Tue, 12 Aug 2003 11:10:51 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@logos.cnet
To: maney@pobox.com
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.22-rc2 ext2 filesystem corruption
In-Reply-To: <20030812134221.GA6412@furrr.two14.net>
Message-ID: <Pine.LNX.4.44.0308121109530.5995-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 12 Aug 2003, Martin Maney wrote:

> On Tue, Aug 12, 2003 at 10:12:19AM -0300, Marcelo Tosatti wrote:
> > Can you tell me exactly how can I try to reproduce the problem you're 
> > seeing? 
> > 
> > With just cp and unmount you can see the corruption? 
> 
> Yes.  With the c. 50MB file it happens every time (now out of a couple
> dozen tests).  A 3MB file did not get corrupted in half a dozen trials,
> including ones where both were copied before the umount.
> 
> The age & condition of the target filesystem don't seem to matter; at
> least I have replicated this immediately following mke2fs of the
> target.  The original observed corruption was on much older and more
> cluttered filesystems - the first sign of trouble was when a local
> build of XFree failed.
> 
> In case I wasn't perfectly clear (it was late, so that may well be), I
> used the umount/mount only to invalidate the buffers; merely syncing
> after copying wouldn't produce any immediate effect.  The copy always
> looks good until the data has to be read back from the target
> filesystem.
> 
> One other item which I didn't think to mention is that the compiler was
> "gcc version 2.95.4 20011002" - Debian's normal compiler in the Woody
> release.  Of course that's been used for every other 2.4 kernel I've
> built here as well.

I'll try to reproduce around here. In the meantime can you try to isolate 
the corruption. You said it didnt happen with 2.4.21 -- which pre shows up 
the problem? 

