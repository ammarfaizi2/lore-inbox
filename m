Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261302AbRENEpw>; Mon, 14 May 2001 00:45:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261334AbRENEpn>; Mon, 14 May 2001 00:45:43 -0400
Received: from [202.54.26.202] ([202.54.26.202]:5600 "EHLO hindon.hss.co.in")
	by vger.kernel.org with ESMTP id <S261302AbRENEph>;
	Mon, 14 May 2001 00:45:37 -0400
X-Lotus-FromDomain: HSS
From: alad@hss.hns.com
To: linux-kernel@vger.kernel.org
Message-ID: <65256A4C.00189FB0.00@sandesh.hss.hns.com>
Date: Mon, 14 May 2001 09:44:53 +0530
Subject: kmem_cache_init ()
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi,
     I was unable to understand the logic of the following sanity checks in
slab.c/kmem_cache_init ().

if (kmem_cache_diff(c_firstp,c_magic) != kmem_slab_diff(s_nextp,s_magic) ||
kmem_cache_diff(c_firstp,c_inuse) != kmem_slab_diff(s_nextp,s_inuse) ||
kmem_cache_offset(c_lastp) - ((unsigned long) kmem_slab_end((kmem_cache_t
*)NULL)) != kmem_slab_offset(s_prevp) || kmem_cache_diff(c_lastp,c_firstp) !=
kmem_slab_diff(s_prevp,s_nextp)) {
     /** offsets to the magic are incorrect **/
}

can someone throw some light behind the above logic

Thanks
Amol


