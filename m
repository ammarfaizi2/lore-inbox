Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136411AbREJUVH>; Thu, 10 May 2001 16:21:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136915AbREJUU7>; Thu, 10 May 2001 16:20:59 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:58780 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S136411AbREJUUt>; Thu, 10 May 2001 16:20:49 -0400
Date: Thu, 10 May 2001 21:19:13 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Mark Hemment <markhe@veritas.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] allocation looping + kswapd CPU cycles
Message-ID: <20010510211913.R16590@redhat.com>
In-Reply-To: <20010510205204.O16590@redhat.com> <Pine.LNX.4.21.0105101517050.19732-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0105101517050.19732-100000@freak.distro.conectiva>; from marcelo@conectiva.com.br on Thu, May 10, 2001 at 03:22:57PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, May 10, 2001 at 03:22:57PM -0300, Marcelo Tosatti wrote:

> Initially I thought about __GFP_FAIL to be used by writeout routines which
> want to cluster pages until they can allocate memory without causing any
> pressure to the system. Something like this: 
> 
> while ((page = alloc_page(GFP_FAIL))
> 	add_page_to_cluster(page);
> write_cluster(); 

Isn't that an orthogonal decision?  You can use __GFP_FAIL with or
without __GFP_WAIT or __GFP_IO, whichever is appropriate.

Cheers,
 Stephen
