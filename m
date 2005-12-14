Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932453AbVLNNOt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932453AbVLNNOt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 08:14:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932468AbVLNNOs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 08:14:48 -0500
Received: from mx1.redhat.com ([66.187.233.31]:20163 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932453AbVLNNOs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 08:14:48 -0500
Date: Wed, 14 Dec 2005 08:14:28 -0500
From: Dave Jones <davej@redhat.com>
To: Andi Kleen <ak@suse.de>
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: stall during boot on x86-64.
Message-ID: <20051214131428.GA3829@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Andi Kleen <ak@suse.de>,
	"Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
	linux-kernel@vger.kernel.org
References: <88056F38E9E48644A0F562A38C64FB60069E67D8@scsmsx403.amr.corp.intel.com> <p73lkyo87m6.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73lkyo87m6.fsf@verdi.suse.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2005 at 08:23:29AM +0100, Andi Kleen wrote:
 > "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com> writes:
 > 
 > > >[    0.000000] time.c: Detected 2793.081 MHz processor.
 > > >[   27.449661] Console: colour VGA+ 80x25
 > > >[   28.484309] Dentry cache hash table entries: 131072 (order: 
 > > >8, 1048576 bytes)
 > > >[   28.506519] Inode-cache hash table entries: 65536 (order: 
 > > >7, 524288 bytes)
 > > >[   28.539543] Memory: 1014240k/1047080k available (2490k 
 > > >kernel code, 32456k reserved, 1664k data, 236k init)
 > > >
 > > >Note the jump in the time value..
 > > 
 > > May be this is just the origin of time as far as kernel is concerned.
 > > No?
 > 
 > It is. Before that the timer interrupt doesn't run and jiffies won't 
 > increase.

Makes sense now. After sleeping on it, I think the stall I see
is caused by framebuffer console. I'll poke some more at it
this evening.

		Dave

