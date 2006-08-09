Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030424AbWHIDIU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030424AbWHIDIU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 23:08:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030433AbWHIDIT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 23:08:19 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:15795 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030424AbWHIDIT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 23:08:19 -0400
Subject: Re: [RFC][PATCH 2/6] x86_64: hpet_address cleanup
From: john stultz <johnstul@us.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200608090431.13309.ak@suse.de>
References: <20060809021707.23103.5607.sendpatchset@cog.beaverton.ibm.com>
	 <20060809021720.23103.26378.sendpatchset@cog.beaverton.ibm.com>
	 <200608090431.13309.ak@suse.de>
Content-Type: text/plain
Date: Tue, 08 Aug 2006 20:08:16 -0700
Message-Id: <1155092896.13030.114.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-09 at 04:31 +0200, Andi Kleen wrote:
> On Wednesday 09 August 2006 04:17, john stultz wrote:
> > In preparation for supporting generic timekeeping, this patch cleans up 
> > x86-64's use of vxtime.hpet_address, changing it to just hpet_address 
> > as is also used in i386. This is necessary since the vxtime structure 
> > will be going away.
> 
> Does the kernel still boot with that patch only? 

Just tested, and yes it still boots, but my box doesn't have HPET so
that isn't much of a test. :(

As I said in the announce mail, I've not boot tested each step, I
suspect patches 4/6 and 5/6 will have troubles (vsyscall isn't disabled,
but the updating is). I'll try to address that in the next release.


> Your new variable doesn't seem to be exported to vsyscalls

The vxtime structure hasn't yet been removed and we set
vxtime.hpet_address = hpet_address in necessary spots, so it should be
ok.


thanks
-john

