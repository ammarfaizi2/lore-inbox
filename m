Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273912AbRIXODI>; Mon, 24 Sep 2001 10:03:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273918AbRIXOC6>; Mon, 24 Sep 2001 10:02:58 -0400
Received: from chunnel.redhat.com ([199.183.24.220]:61172 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S273912AbRIXOCm>; Mon, 24 Sep 2001 10:02:42 -0400
Date: Mon, 24 Sep 2001 15:02:59 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Juergen Doelle <jdoelle@de.ibm.com>
Cc: Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@zip.com.au>,
        linux-kernel@vger.kernel.org, Mark Hemment <markhe@veritas.com>,
        lse-tech@lists.sourceforge.net, Steve Fox <stevefx@us.ibm.com>,
        Stephen Tweedie <sct@redhat.com>
Subject: Re: [PATCH] Align VM locks, new spinlock patch
Message-ID: <20010924150259.A13817@redhat.com>
In-Reply-To: <3BAB3D65.2FDD170C@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BAB3D65.2FDD170C@de.ibm.com>; from jdoelle@de.ibm.com on Fri, Sep 21, 2001 at 03:15:17PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Sep 21, 2001 at 03:15:17PM +0200, Juergen Doelle wrote:

>     2.4.10  2.4.10 +        improvement 
>             spinlock patch  by patch    
> 
>  U  103.77  102.14          - 1.6%
>  1   96.82   96.77          - 0.1%
>  2  155.32  155.62            0.2%
>  4  209.45  222.11            6.0%
>  8  208.06  234.82           12.9%
> 
> The improvement is less than in previous posted results, because the 
> pagemap_lru_lock and the lru_list_lock are already cacheline aligned
> in 2.4.10 (2.4.9).

Do you have CPU utilisation differences for these cases, as well as
pure IO bandwidth differences?  It would be interesting to see just
how much the IO code's internal latency impacts on the final dbench
numbers.

--Stephen
