Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263128AbUDBClI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 21:41:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263136AbUDBClI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 21:41:08 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:14749
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263128AbUDBClG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 21:41:06 -0500
Date: Fri, 2 Apr 2004 04:41:04 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: chrisw@osdl.org, linux-kernel@vger.kernel.org, kenneth.w.chen@intel.com
Subject: Re: disable-cap-mlock
Message-ID: <20040402024104.GS18585@dualathlon.random>
References: <20040401135920.GF18585@dualathlon.random> <20040401170705.Y22989@build.pdx.osdl.net> <20040401173034.16e79fee.akpm@osdl.org> <20040401175914.A22989@build.pdx.osdl.net> <20040402020915.GO18585@dualathlon.random> <20040401183026.6844597a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040401183026.6844597a.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2004 at 06:30:26PM -0800, Andrew Morton wrote:
> I guess so.

sounds very good then, I'll send a notice.

> Well you have a local short-term solution...

yep...

> One thing I was wondering was whether /proc/sys/vm/disable_cap_mlock should
> hold a GID rather than a boolean.  So you do
> 
> 	echo groupof oracle > /proc/sys/vm/disable_cap_mlock

that's probably optimal OTOH that would complicate the code, I prefer an
obviously safe !disable_cap_mlock, if we want to go complicated we can
probably wait the userspace solution ;)
