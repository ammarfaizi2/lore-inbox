Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030623AbWBIFoE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030623AbWBIFoE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 00:44:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030622AbWBIFoD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 00:44:03 -0500
Received: from cabal.ca ([134.117.69.58]:25994 "EHLO fattire.cabal.ca")
	by vger.kernel.org with ESMTP id S1030623AbWBIFoB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 00:44:01 -0500
Date: Thu, 9 Feb 2006 00:42:31 -0500
From: Kyle McMartin <kyle@parisc-linux.org>
To: "Robb, Sam" <sam.robb@timesys.com>
Cc: akpm@osdl.org, zippel@linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kconfig: detect if -lintl is needed when linking conf,mconf
Message-ID: <20060209054231.GB1615@quicksilver.road.mcmartin.ca>
References: <3D848382FB72E249812901444C6BDB1D0908A150@exchange.timesys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D848382FB72E249812901444C6BDB1D0908A150@exchange.timesys.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2006 at 01:26:47PM -0500, Robb, Sam wrote:
>   This patch attempts to correct the problem by detecting whether or not
> NLS support requires linking with libintl.
>

Sigh. Can everyone please stop assuming gcc can output to /dev/null? On 
several platforms, ld tries to lseek in the output file, and fails if it 
can't.

Is there any reason this problem can't be solved the same way it is
for libcurses in menuconfig, by using gcc -print-filename? Or perhaps
using tempfile?

Cheers,
	Kyle
