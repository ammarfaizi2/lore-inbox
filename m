Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267338AbTACAVq>; Thu, 2 Jan 2003 19:21:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267340AbTACAVq>; Thu, 2 Jan 2003 19:21:46 -0500
Received: from holomorphy.com ([66.224.33.161]:55494 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267338AbTACAVq>;
	Thu, 2 Jan 2003 19:21:46 -0500
Date: Thu, 2 Jan 2003 16:30:06 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
Cc: linux-kernel@vger.kernel.org, jmerkey@timpanogas.org
Subject: Re: Question about Zone Allocation 2.4.X
Message-ID: <20030103003006.GX9704@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Jeff V. Merkey" <jmerkey@vger.timpanogas.org>,
	linux-kernel@vger.kernel.org, jmerkey@timpanogas.org
References: <20030102175517.A21471@vger.timpanogas.org> <20030102235147.GS9704@holomorphy.com> <20030102180849.A21498@vger.timpanogas.org> <20030103000034.GU9704@holomorphy.com> <20030102181554.A21643@vger.timpanogas.org> <20030103001127.GV9704@holomorphy.com> <20030102183218.A21808@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030102183218.A21808@vger.timpanogas.org>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 02, 2003 at 04:11:27PM -0800, William Lee Irwin III wrote:
>> Adding new zone types is easy. Just add them to mmzone.h, avoid setting
>> ->virtual (which does not universally exist) in free_area_init_core()
>> if it's not perma-mapped, stuff them in the fallback sequence in
>> build_zonelists(), and detect them in arch/*/mm/init.c

On Thu, Jan 02, 2003 at 06:32:18PM -0700, Jeff V. Merkey wrote:
> I also just reviewed the changes to the mmu code mode by Ingo -- very ugly
> stuff.  Looks like both changes are required to get this working properly 
> since without the PDE being setup properly, we'll get page faults since the 
> AS above 1GB is not mapped by the mmu.

Not a big deal. Just kmap()/kunmap() or kmap_atomic()/kunmap_atomic()
as needed. Physical address extensions and this kind of windowing has
been around long enough to just be "there", not ugly, pretty, or
interesting. It should all be well enough understood these days that
either myself or a few dozen others could help there.


Bill
