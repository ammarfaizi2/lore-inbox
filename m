Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261569AbVDCSNX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261569AbVDCSNX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 14:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261844AbVDCSNX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 14:13:23 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:20188 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261569AbVDCSNU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 14:13:20 -0400
Date: Sun, 3 Apr 2005 19:13:18 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Dag Arne Osvik <da@osvik.no>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org
Subject: Re: Use of C99 int types
Message-ID: <20050403181318.GW8859@parcelfarce.linux.theplanet.co.uk>
References: <424FD9BB.7040100@osvik.no> <20050403220508.712e14ec.sfr@canb.auug.org.au> <424FE1D3.9010805@osvik.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <424FE1D3.9010805@osvik.no>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 03, 2005 at 02:30:11PM +0200, Dag Arne Osvik wrote:
> Yes, but wouldn't it be much better to avoid code like the following, 
> which may also be wrong (in terms of speed)?
> 
> #ifdef CONFIG_64BIT  // or maybe CONFIG_X86_64?
>  #define fast_u32 u64
> #else
>  #define fast_u32 u32
> #endif

... and with such name 99% will assume (at least at the first reading)
that it _is_ 32bits.  We have more than enough portability bugs as it
is, no need to invite more by bad names.
