Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132890AbRDQV7r>; Tue, 17 Apr 2001 17:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132900AbRDQV7i>; Tue, 17 Apr 2001 17:59:38 -0400
Received: from vger.timpanogas.org ([207.109.151.240]:8208 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S132890AbRDQV73>; Tue, 17 Apr 2001 17:59:29 -0400
Date: Tue, 17 Apr 2001 15:52:54 -0600
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: linux-kernel@vger.kernel.org
Cc: jmerkey@timpanogas.org
Subject: Re: BUG() at line 804, slab.c, 2.4.3
Message-ID: <20010417155254.A344@vger.timpanogas.org>
In-Reply-To: <20010417152920.A32576@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20010417152920.A32576@vger.timpanogas.org>; from jmerkey@vger.timpanogas.org on Tue, Apr 17, 2001 at 03:29:20PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 17, 2001 at 03:29:20PM -0600, Jeff V. Merkey wrote:

Added kmem_cache_destroy() to get around the problem.  I'm still
curious as to why we need to panic at this point rather than return
an error.  

Thanks

Jeff

> 
> 
> I noticed that subsequent calls to kmem_cache_create with the same name
> does not return an -EEXIST return code, but instead barfs and crashes
> with a bug at slab.c line 804.  This occurs in 2.4.3.
> 
> Is this the expected behavior for kmem_cache_create?  I am using 
> the slab allocator to create and maintain buffer head chains for 
> asynch I/O.
>  
> I would assume that if a valid tag existed, an error would be returned 
> rather than the system crashing.   I see the problem unloading then 
> reloading the module on 2.4.3.  
> 
> Thanks,
> 
> Jeff
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
