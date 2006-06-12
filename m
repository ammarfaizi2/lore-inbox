Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751973AbWFLOr7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751973AbWFLOr7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 10:47:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751982AbWFLOr7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 10:47:59 -0400
Received: from waste.org ([64.81.244.121]:60293 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1751973AbWFLOr7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 10:47:59 -0400
Date: Mon, 12 Jun 2006 09:37:48 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86 built-in command line
Message-ID: <20060612143748.GN24227@waste.org>
References: <20060611215530.GH24227@waste.org> <p73odwyssib.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73odwyssib.fsf@verdi.suse.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2006 at 10:11:24AM +0200, Andi Kleen wrote:
> Matt Mackall <mpm@selenic.com> writes:
> 
> > This patch allows building in a kernel command line on x86 as is
> > possible on several other arches.
> 
> I'm surprised you didn't do the obvious "tiny" changes associated with
> that. Look at the static array sizes of the command line buffers.

They're not entirely obvious. The saved command line buffer size is
currently fixed so if we set a default that's larger, we'd like to
have a compile failure if it's too large.

Next step here is to make the buffer size configurable, which will
allow people to use command lines longer (or shorter!) than the boot
protocol allows (256 bytes on x86).

-- 
Mathematics is the supreme nostalgia of our time.
