Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266146AbTGDTj5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 15:39:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266147AbTGDTj5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 15:39:57 -0400
Received: from franka.aracnet.com ([216.99.193.44]:64493 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S266146AbTGDTj4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 15:39:56 -0400
Date: Fri, 04 Jul 2003 12:53:54 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: William Lee Irwin III <wli@holomorphy.com>
cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Helge Hafting <helgehaf@aitel.hist.no>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.74-mm1 fails to boot due to APIC trouble, 2.5.73mm3 works.
Message-ID: <16900000.1057348432@[10.10.2.4]>
In-Reply-To: <20030704193135.GF955@holomorphy.com>
References: <20030703023714.55d13934.akpm@osdl.org> <Pine.LNX.4.53.0307041139150.24383@montezuma.mastecende.com> <13170000.1057335490@[10.10.2.4]> <20030704183106.GC955@holomorphy.com> <14820000.1057346400@[10.10.2.4]> <20030704193135.GF955@holomorphy.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--William Lee Irwin III <wli@holomorphy.com> wrote (on Friday, July 04, 2003 12:31:35 -0700):

> At some point in the past, I wrote:
>>> The bitmap is wider than the function wants. The change is fine, despite
>>> your abuse of phys_cpu_present_map.
> 
> On Fri, Jul 04, 2003 at 12:20:02PM -0700, Martin J. Bligh wrote:
>> I'm happy to remove the abuse of phys_cpu_present_map, seeing as we now
>> have a reason to do so. That would actually seem a much cleaner solution
>> to these problems than creating a whole new data type, which still doesn't
>> represent what it claims to
> 
> Dirtier, but possibly lower line count.

I disagree with the "dirtier" bit, but still. I'd rather have this sort
of stuff put into subarch, where most people don't have to look at it.

More to the point, the changes would be confined to the big-iron arches,
and have less chance of breaking anyone else for things they don't
care about, nor do them any benefit. Touching this code is fragile as
hell, so if it can be confined, it should be ...

It'd also remove the long-standing abuse of phys_cpu_present_map, which
would probably make the rest of the code clearer.

M.

