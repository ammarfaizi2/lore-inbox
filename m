Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267346AbTACANr>; Thu, 2 Jan 2003 19:13:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267347AbTACANr>; Thu, 2 Jan 2003 19:13:47 -0500
Received: from vger.timpanogas.org ([216.250.140.154]:53730 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S267346AbTACANq>; Thu, 2 Jan 2003 19:13:46 -0500
Date: Thu, 2 Jan 2003 18:32:18 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org,
       jmerkey@timpanogas.org
Cc: jmerkey@timpanogas.org
Subject: Re: Question about Zone Allocation 2.4.X
Message-ID: <20030102183218.A21808@vger.timpanogas.org>
References: <20030102175517.A21471@vger.timpanogas.org> <20030102235147.GS9704@holomorphy.com> <20030102180849.A21498@vger.timpanogas.org> <20030103000034.GU9704@holomorphy.com> <20030102181554.A21643@vger.timpanogas.org> <20030103001127.GV9704@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030103001127.GV9704@holomorphy.com>; from wli@holomorphy.com on Thu, Jan 02, 2003 at 04:11:27PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 02, 2003 at 04:11:27PM -0800, William Lee Irwin III wrote:
> 
> Adding new zone types is easy. Just add them to mmzone.h, avoid setting
> ->virtual (which does not universally exist) in free_area_init_core()
> if it's not perma-mapped, stuff them in the fallback sequence in
> build_zonelists(), and detect them in arch/*/mm/init.c
> 

Bill,

I also just reviewed the changes to the mmu code mode by Ingo -- very ugly
stuff.  Looks like both changes are required to get this working properly 
since without the PDE being setup properly, we'll get page faults since the 
AS above 1GB is not mapped by the mmu.

Jeff


> 
> Bill
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
