Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269794AbUJGL2M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269794AbUJGL2M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 07:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269796AbUJGL2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 07:28:12 -0400
Received: from cantor.suse.de ([195.135.220.2]:28090 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S269794AbUJGL2J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 07:28:09 -0400
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: __init poisoning for i386, too
References: <20041006221854.GA1622@elf.ucw.cz.suse.lists.linux.kernel>
	<20041007061610.GU9106@holomorphy.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 07 Oct 2004 13:28:08 +0200
In-Reply-To: <20041007061610.GU9106@holomorphy.com.suse.lists.linux.kernel>
Message-ID: <p73brfeu5rr.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> writes:

> On Thu, Oct 07, 2004 at 12:18:55AM +0200, Pavel Machek wrote:
> > Overwrite __init section so calls to __init functions from normal code
> > are catched, reliably. I wonder if this should be configurable... but
> > it is configurable on x86-64 so I copied it. Please apply,
> 
> Any chance we could:
> (a) set the stuff to 0x0f0b so illegal instructions come of it; jumps are
> 	most often aligned to something > 16 bits anyway

0xcc is an int3, that already causes an oops.

> (b) poison __initdata, memsetting to some bit pattern oopsable to dereference

Would be a good idea yes. I will add it to x86-64.

-Andi
