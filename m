Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279598AbRJ2XPL>; Mon, 29 Oct 2001 18:15:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279601AbRJ2XPB>; Mon, 29 Oct 2001 18:15:01 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:62996 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S279598AbRJ2XOv>; Mon, 29 Oct 2001 18:14:51 -0500
Date: Mon, 29 Oct 2001 18:15:28 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: "David S. Miller" <davem@redhat.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: please revert bogus patch to vmscan.c
Message-ID: <20011029181527.G25434@redhat.com>
In-Reply-To: <20011029180837.F25434@redhat.com> <20011029.151422.102554141.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011029.151422.102554141.davem@redhat.com>; from davem@redhat.com on Mon, Oct 29, 2001 at 03:14:22PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2001 at 03:14:22PM -0800, David S. Miller wrote:
>    From: Benjamin LaHaise <bcrl@redhat.com>
>    Date: Mon, 29 Oct 2001 18:08:37 -0500
> 
>    is completely bogus.  Without the tlb flush, the system may never update 
>    the accessed bit on a page that is heavily being used.
> 
> It's intentional Ben, think about the high cost of the SMP invalidate
> when kswapd is just scanning page tables.

I think it's far more expensive to pull a page back in from disk.

		-ben
