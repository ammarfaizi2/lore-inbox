Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263380AbUDUVDl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263380AbUDUVDl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 17:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263702AbUDUVDl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 17:03:41 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:8635 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S263380AbUDUVDk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 17:03:40 -0400
Date: Thu, 22 Apr 2004 02:31:18 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Christoph Hellwig <hch@infradead.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390 (9/9): no timer interrupts in idle.
Message-ID: <20040421210118.GD4024@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <OF9B34CCE6.C0CD3DC5-ONC1256E7D.005B1592-C1256E7D.005B528B@de.ibm.com> <20040421204303.GA5014@in.ibm.com> <20040421214605.A11291@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040421214605.A11291@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2004 at 09:46:05PM +0100, Christoph Hellwig wrote:
> On Thu, Apr 22, 2004 at 02:13:04AM +0530, Dipankar Sarma wrote:
> > I think CPU_MASK_NONE can be used only for assignments. You need
> > to actually declare a generic idle_cpu_mask and set it to CPU_MASK_NONE
> > for all other archs. Of course, then the compiler will not be able
> > to optimize it out :)
> 
> Well, there's a const keyword in C these days, no?

OK, then I missed what optimization you were talking about or underestimated
gcc. Can gcc do inter-procedural constant propagation ?

Thanks
Dipankar
