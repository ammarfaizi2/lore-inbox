Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261526AbTCGLnz>; Fri, 7 Mar 2003 06:43:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261543AbTCGLny>; Fri, 7 Mar 2003 06:43:54 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:41897
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261526AbTCGLnw>; Fri, 7 Mar 2003 06:43:52 -0500
Subject: Re: [PATCH] vm_area_struct slab corruption
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@digeo.com>
Cc: Hugh Dickins <hugh@veritas.com>, vandrove@vc.cvut.cz,
       helgehaf@aitel.hist.no,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030306220053.1d757ed6.akpm@digeo.com>
References: <20030306145223.67d571b1.akpm@digeo.com>
	 <Pine.LNX.4.44.0303070454320.1938-100000@localhost.localdomain>
	 <20030306220053.1d757ed6.akpm@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1047041996.20794.21.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 07 Mar 2003 12:59:57 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-03-07 at 06:00, Andrew Morton wrote:
> This looks pretty simple?  Is it not just a matter of propagating that flag
> down to unmap_region()?  I don't see where drivers and such are involved?

Only two or three. i8xx DRM uses do_munmap as does ipc/shm.c. I think the 
shmem fs may also do so but I'd have to check.

