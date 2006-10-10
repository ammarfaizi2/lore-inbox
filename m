Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030270AbWJJUUi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030270AbWJJUUi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 16:20:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030273AbWJJUUi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 16:20:38 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:20668 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030271AbWJJUUg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 16:20:36 -0400
Date: Tue, 10 Oct 2006 15:20:34 -0500
To: Olof Johansson <olof@lixom.net>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, Vadim Lobanov <vlobanov@speakeasy.net>
Subject: Re: BUG() in copy_fdtable() with 64K pages (2.6.19-rc1-mm1)
Message-ID: <20061010202034.GV4381@austin.ibm.com>
References: <20061010000928.9d2d519a.akpm@osdl.org> <20061010121519.447d62f8@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061010121519.447d62f8@localhost.localdomain>
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2006 at 12:15:19PM -0500, Olof Johansson wrote:
> I keep hitting this on -rc1-mm1. The system comes up but I can't login
> since login hits it.
> 
> Bisect says that fdtable-implement-new-pagesize-based-fdtable-allocator.patch is at fault.
> 
> CONFIG_PPC_64K_PAGES=y is required for it to fail, with 4K pages it's fine.
> 
> (Hardware is a Quad G5, 1GB RAM, g5_defconfig + CONFIG_PPC_64K_PAGES, defaults 
> on all new options)
> 
> 
> 
> kernel BUG in copy_fdtable at fs/file.c:138!

FWIW, I too was hitting this bug, during init:

[   41.659823] Freeing unused kernel memory: 320k freed
INIT: version 2.86 bootin[   42.509322] kernel BUG in copy_fdtable at fs/file.c:138!

and of course systm does not come up.

--linas


