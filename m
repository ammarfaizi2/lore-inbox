Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132871AbRDQVgO>; Tue, 17 Apr 2001 17:36:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132872AbRDQVgE>; Tue, 17 Apr 2001 17:36:04 -0400
Received: from vger.timpanogas.org ([207.109.151.240]:1808 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S132871AbRDQVfw>; Tue, 17 Apr 2001 17:35:52 -0400
Date: Tue, 17 Apr 2001 15:29:20 -0600
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: linux-kernel@vger.kernel.org
Cc: jmerkey@timpanogas.org
Subject: BUG() at line 804, slab.c, 2.4.3
Message-ID: <20010417152920.A32576@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I noticed that subsequent calls to kmem_cache_create with the same name
does not return an -EEXIST return code, but instead barfs and crashes
with a bug at slab.c line 804.  This occurs in 2.4.3.

Is this the expected behavior for kmem_cache_create?  I am using 
the slab allocator to create and maintain buffer head chains for 
asynch I/O.
 
I would assume that if a valid tag existed, an error would be returned 
rather than the system crashing.   I see the problem unloading then 
reloading the module on 2.4.3.  

Thanks,

Jeff
