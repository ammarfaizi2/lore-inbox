Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266812AbUG1IWJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266812AbUG1IWJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 04:22:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266814AbUG1IWJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 04:22:09 -0400
Received: from holomorphy.com ([207.189.100.168]:52105 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266812AbUG1IWG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 04:22:06 -0400
Date: Wed, 28 Jul 2004 01:20:37 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "David S. Miller" <davem@redhat.com>
Cc: kaos@sgi.com, akpm@osdl.org, zwane@linuxpower.ca, ak@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.6] Allow x86_64 to reenable interrupts on contention
Message-ID: <20040728082037.GM2334@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"David S. Miller" <davem@redhat.com>, kaos@sgi.com, akpm@osdl.org,
	zwane@linuxpower.ca, ak@suse.de, linux-kernel@vger.kernel.org
References: <20040728004030.GK2334@holomorphy.com> <2479.1090979285@kao2.melbourne.sgi.com> <20040728022131.GL2334@holomorphy.com> <20040727192454.787c6b62.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040727192454.787c6b62.davem@redhat.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jul 2004 19:21:31 -0700 William Lee Irwin III wrote:
>> and may also have issues with
>> architectures (e.g. sparc/sparc64) which need the interrupt disablement
>> in e.g. spin_lock_irqsave() to be done in the same call frame as the
>> spin_unlock_irqrestore() etc.

On Tue, Jul 27, 2004 at 07:24:54PM -0700, David S. Miller wrote:
> This only was a problem on sparc, and it no longer exists at all
> in 2.6.x kernels.  It was too much of a pain to keep teaching
> people that violated this, and it resulted in some contorted
> code as well.
> So don't worry about this at all in 2.6.x and later.

Thanks; that explains whether it worked by coincidence or design.
No idea why I thought sparc64 did similar.


-- wli
