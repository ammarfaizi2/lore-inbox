Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261853AbTHTKBQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 06:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261856AbTHTKBQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 06:01:16 -0400
Received: from ns.suse.de ([195.135.220.2]:51672 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261853AbTHTKBP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 06:01:15 -0400
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org, venkatesh.pallipadi@intel.com
Subject: Re: [PATCH][2.6][2/5]Support for HPET based timer
References: <C8C38546F90ABF408A5961FC01FDBF1902C7D1C9@fmsmsx405.fm.intel.com.suse.lists.linux.kernel>
	<20030820080513.GB17793@ucw.cz.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 20 Aug 2003 12:01:13 +0200
In-Reply-To: <20030820080513.GB17793@ucw.cz.suse.lists.linux.kernel>
Message-ID: <p731xvg7imu.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik <vojtech@suse.cz> writes:

> On Tue, Aug 19, 2003 at 05:18:50PM -0700, Pallipadi, Venkatesh wrote:
> 
> > Fixmap is for HPET memory map address access. As the timer
> > initialization happen 
> > early in the boot sequence (before vm initialization), we need to have
> > fixmap() 
> > and fix_to_virt() to access HPET memory map address.
> 
> Ahh, yes, you're right. You can't use ioremap at that time. Actually I
> did the same on x86_64 not only because of vsyscalls.

iirc i386 has an ioremap_early or somesuch.

-Andi
