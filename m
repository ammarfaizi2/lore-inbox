Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750812AbWFLRSu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750812AbWFLRSu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 13:18:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751158AbWFLRSt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 13:18:49 -0400
Received: from hera.kernel.org ([140.211.167.34]:4242 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1750812AbWFLRSt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 13:18:49 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86 built-in command line
Date: Mon, 12 Jun 2006 10:18:26 -0700 (PDT)
Organization: Mostly alphabetical, except Q, with we do not fancy
Message-ID: <e6k7l2$h34$1@terminus.zytor.com>
References: <20060611215530.GH24227@waste.org> <p73odwyssib.fsf@verdi.suse.de> <20060612143748.GN24227@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1150132706 17509 127.0.0.1 (12 Jun 2006 17:18:26 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Mon, 12 Jun 2006 17:18:26 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20060612143748.GN24227@waste.org>
By author:    Matt Mackall <mpm@selenic.com>
In newsgroup: linux.dev.kernel
>
> On Mon, Jun 12, 2006 at 10:11:24AM +0200, Andi Kleen wrote:
> > Matt Mackall <mpm@selenic.com> writes:
> > 
> > > This patch allows building in a kernel command line on x86 as is
> > > possible on several other arches.
> > 
> > I'm surprised you didn't do the obvious "tiny" changes associated with
> > that. Look at the static array sizes of the command line buffers.
> 
> They're not entirely obvious. The saved command line buffer size is
> currently fixed so if we set a default that's larger, we'd like to
> have a compile failure if it's too large.
> 
> Next step here is to make the buffer size configurable, which will
> allow people to use command lines longer (or shorter!) than the boot
> protocol allows (256 bytes on x86).
> 

The boot protocol 256-byte limitation applies only to protocol version
2.01 or earlier.  After that, there is still a 256-byte *KERNEL*
limitation, but it is not a *PROTOCOL* limitation.  In other words,
the kernel can, and should be, upgraded; in fact, a gentleman by the
name of Alon Bar-Lev has submitted that patch several times already;
it wasn't accepted because of an unsubstantiated report that it broke
LILO, the veracity of which I think is in serious doubt.

	-hpa

