Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268177AbTB1VQh>; Fri, 28 Feb 2003 16:16:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268179AbTB1VQh>; Fri, 28 Feb 2003 16:16:37 -0500
Received: from packet.digeo.com ([12.110.80.53]:64937 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S268177AbTB1VQe>;
	Fri, 28 Feb 2003 16:16:34 -0500
Date: Fri, 28 Feb 2003 13:23:22 -0800
From: Andrew Morton <akpm@digeo.com>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: linux-kernel@vger.kernel.org, Hugh Dickins <hugh@veritas.com>
Subject: Re: Memory modified after freeing in 2.5.63?
Message-Id: <20030228132322.1ec5689a.akpm@digeo.com>
In-Reply-To: <20030228150447.GA3862@vana.vc.cvut.cz>
References: <20030228150447.GA3862@vana.vc.cvut.cz>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Feb 2003 21:26:49.0208 (UTC) FILETIME=[1A66EF80:01C2DF70]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Vandrovec <vandrove@vc.cvut.cz> wrote:
>
> Hi,
>   for some time I'm using patch attached at the end of this email, 
> which modifies check_poison function to not only verify that
> last byte is POISON_END, but also that all preceeding bytes are
> either POISON_BEFORE or POISON_AFTER bytes. 

Nice patch.

>   And now when I returned from my month vacation and upgraded 
> from 2.5.52 to 2.5.63, when dselect/apt updates dozens of packages, 
> I'm getting memory corruption reports as shown below - 22nd byte 
> in vm_area_struct - which looks like that VM_ACCOUNT in vm_flags 
> is set after vma is freeed...  Any clue? Setting VM_ACCOUNT
> in mremap.c:move_vma after calling do_unmap() looks suspicious
> to me, but as I know almost nothing about MM...

Ha!  I've been harrassing Hugh over this ;)

Thanks.


