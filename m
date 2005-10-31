Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751302AbVJaVTg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751302AbVJaVTg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 16:19:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298AbVJaVTg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 16:19:36 -0500
Received: from waste.org ([216.27.176.166]:32203 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1751296AbVJaVTe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 16:19:34 -0500
Date: Mon, 31 Oct 2005 13:14:22 -0800
From: Matt Mackall <mpm@selenic.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 13/20] inflate: (arch) kill silly zlib typedefs
Message-ID: <20051031211422.GC4367@waste.org>
References: <14.196662837@selenic.com> <Pine.LNX.4.62.0510312204400.26471@numbat.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0510312204400.26471@numbat.sonytel.be>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2005 at 10:05:15PM +0100, Geert Uytterhoeven wrote:
> On Mon, 31 Oct 2005, Matt Mackall wrote:
> > inflate: remove legacy type definitions from callers
> > 
> > This replaces the legacy zlib typedefs and usage with kernel types in
> > all the inflate users.
> 
> > -static ulg free_mem_ptr;
> > -static ulg free_mem_ptr_end;
> > +static u32 free_mem_ptr;
> > +static u32 free_mem_ptr_end;
> 
> Bang, on 64-bit platforms...

That was quick.

Yes, this is broken on Alpha. The other 64-bit arches use proper pointers
here. But I need to change all the arches to use the same pointer
type, probably as patch 8.5 in the series.

-- 
Mathematics is the supreme nostalgia of our time.
