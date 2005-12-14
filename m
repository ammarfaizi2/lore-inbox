Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751282AbVLNHXb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751282AbVLNHXb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 02:23:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbVLNHXb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 02:23:31 -0500
Received: from mx2.suse.de ([195.135.220.15]:53966 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751282AbVLNHXb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 02:23:31 -0500
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: linux-kernel@vger.kernel.org, davej@redhat.com
Subject: Re: stall during boot on x86-64.
References: <88056F38E9E48644A0F562A38C64FB60069E67D8@scsmsx403.amr.corp.intel.com>
From: Andi Kleen <ak@suse.de>
Date: 14 Dec 2005 08:23:29 +0100
In-Reply-To: <88056F38E9E48644A0F562A38C64FB60069E67D8@scsmsx403.amr.corp.intel.com>
Message-ID: <p73lkyo87m6.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com> writes:

> >[    0.000000] time.c: Detected 2793.081 MHz processor.
> >[   27.449661] Console: colour VGA+ 80x25
> >[   28.484309] Dentry cache hash table entries: 131072 (order: 
> >8, 1048576 bytes)
> >[   28.506519] Inode-cache hash table entries: 65536 (order: 
> >7, 524288 bytes)
> >[   28.539543] Memory: 1014240k/1047080k available (2490k 
> >kernel code, 32456k reserved, 1664k data, 236k init)
> >
> >Note the jump in the time value..
> 
> May be this is just the origin of time as far as kernel is concerned.
> No?

It is. Before that the timer interrupt doesn't run and jiffies won't 
increase.

-Andi
