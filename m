Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268478AbTCFWqR>; Thu, 6 Mar 2003 17:46:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268472AbTCFWqR>; Thu, 6 Mar 2003 17:46:17 -0500
Received: from packet.digeo.com ([12.110.80.53]:45815 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S268478AbTCFWqL>;
	Thu, 6 Mar 2003 17:46:11 -0500
Date: Thu, 6 Mar 2003 14:52:23 -0800
From: Andrew Morton <akpm@digeo.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: vandrove@vc.cvut.cz, helgehaf@aitel.hist.no, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vm_area_struct slab corruption
Message-Id: <20030306145223.67d571b1.akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.44.0303061208470.2196-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0303061208470.2196-100000@localhost.localdomain>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Mar 2003 22:56:33.0644 (UTC) FILETIME=[A2412AC0:01C2E433]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hugh@veritas.com> wrote:
>
> +	 * Note: mremap's move_vma VM_ACCOUNT handling assumes a partially
> +	 * unmapped vm_area_struct will remain in use: so lower split_vma
> +	 * places tmp vma above, and higher split_vma places tmp vma below.

Cough.  Would it be clearer to just return the address of the surviving vma
from do_munmap()?  Via an extra arg, or a PTR_ERR thingy?

