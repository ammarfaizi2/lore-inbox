Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265090AbTFYVXD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 17:23:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265091AbTFYVXD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 17:23:03 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:11016 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S265090AbTFYVWu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 17:22:50 -0400
Date: Wed, 25 Jun 2003 23:42:48 +0200
To: Timothy Miller <miller@techsource.com>
Cc: John Bradford <john@grabjohn.com>, felipe_alfaro@linuxmail.org,
       linux-kernel@vger.kernel.org
Subject: Re: O(1) scheduler & interactivity improvements
Message-ID: <20030625214248.GB2753@hh.idb.hist.no>
References: <200306231244.h5NCiE1Q000920@81-2-122-30.bradfords.org.uk> <20030623163234.GA1184@hh.idb.hist.no> <3EF8D3A9.4040109@techsource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EF8D3A9.4040109@techsource.com>
User-Agent: Mutt/1.5.4i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 24, 2003 at 06:41:45PM -0400, Timothy Miller wrote:
> 
> 
> Helge Hafting wrote:
> >On Mon, Jun 23, 2003 at 01:44:14PM +0100, John Bradford wrote:
> >
> >>Well, no, opaque window moving is fine if the CPU isn't at 100%.  If
> >>it is, I'd rather see choppy window movements than have a server
> >>application starved of CPU.  That's just my preference, though.
> >>
> >
> >That could be an interesting hack to a window manager - 
> >don't start the move in opaque mode when the load is high.
> 
> This isn't really an issue if the graphics engine is doing the work and 
> the X server doesn't busy-wait on the bitblt to finish (ie. does DMA or 
> calls ioctl to sleep until command-fifo-has-free-space interrupt).

The problem isn't window movement, but all the stuff you uncover
forcing repainting all over the place.

Helge Hafting
