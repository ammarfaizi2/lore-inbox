Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263675AbUJ2X6h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263675AbUJ2X6h (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 19:58:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263552AbUJ2XoA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 19:44:00 -0400
Received: from cantor.suse.de ([195.135.220.2]:6622 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263693AbUJ2XkT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 19:40:19 -0400
Date: Sat, 30 Oct 2004 01:39:11 +0200
From: Andi Kleen <ak@suse.de>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.10-rc1-mm2: konqueror segfaults for no reason
Message-ID: <20041029233911.GI31914@wotan.suse.de>
References: <200410291823.34175.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410291823.34175.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2004 at 06:23:34PM +0200, Rafael J. Wysocki wrote:
> Hi,
> 
> On 2.6.10-rc1-mm2 with SuSE 9.1 /x86_64 konqueror always crashes for no 
> specific reason and the following messages appear in dmesg:
> 
> local[18494]: segfault at 0000003000000018 rip 0000000000428f2a rsp 
> 0000007fbfffe870 error 4
> local[18493]: segfault at 0000003000000018 rip 0000000000428f2a rsp 
> 0000007fbfffe870 error 4
> 
> This does not happen on 2.6.10-rc1.
> 
> The .config is available at:
> http://www.sisk.pl/kernel/041029/2.6.10-rc1-mm2.config

Can you back out patches and try to figure out which one caused it? 
Doing a strace -f -o LOG of konqueror before the fault may also be interesting
to see what it did before it crashes.

-Andi

