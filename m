Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263997AbTKJQ6D (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 11:58:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263999AbTKJQ6D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 11:58:03 -0500
Received: from delerium.codemonkey.org.uk ([81.187.208.145]:27567 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S263997AbTKJQ6A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 11:58:00 -0500
Date: Mon, 10 Nov 2003 16:56:54 +0000
From: Dave Jones <davej@redhat.com>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Petr Vandrovec <vandrove@vc.cvut.cz>, linux-kernel@vger.kernel.org
Subject: Re: EFAULT reading /dev/mem... - broken x86info
Message-ID: <20031110165654.GS10144@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Manfred Spraul <manfred@colorfullife.com>,
	Petr Vandrovec <vandrove@vc.cvut.cz>, linux-kernel@vger.kernel.org
References: <20031108162737.GB26350@vana.vc.cvut.cz> <20031110161114.GM10144@redhat.com> <3FAFC1D1.3090309@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FAFC1D1.3090309@colorfullife.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 10, 2003 at 05:50:25PM +0100, Manfred Spraul wrote:
 > It breaks either your app or your AGP driver - what's simpler to fix? 
 > I'm biased, because if you update the AGP driver, then I must figure out 
 > how to fix DEBUG_PAGEALLOC 8-)

I'm not convinced changing agpgart is worth the pain.
The only userspace app that actually grovels through the aperture
in this way is the agpgart test code, so this shouldn't be an issue.

I thought the DEBUG_PAGEALLOC stuff just unmapped pages that had been
kmalloc'd ?  The area of memory we're trying to read those mptables from
shouldn't be unmapped in the first place should they ? Confused.

		Dave

