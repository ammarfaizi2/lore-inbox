Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262081AbVCAXIH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262081AbVCAXIH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 18:08:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262086AbVCAXIG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 18:08:06 -0500
Received: from colin2.muc.de ([193.149.48.15]:51464 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S262081AbVCAXHu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 18:07:50 -0500
Date: 2 Mar 2005 00:07:49 +0100
Date: Wed, 2 Mar 2005 00:07:49 +0100
From: Andi Kleen <ak@muc.de>
To: Bernd Schubert <bernd-schubert@web.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       nfs@lists.sourceforge.net
Subject: Re: x86_64: 32bit emulation problems
Message-ID: <20050301230749.GA79861@muc.de>
References: <200502282154.08009.bernd.schubert@pci.uni-heidelberg.de> <200503012207.02915.bernd-schubert@web.de> <20050301214832.GA44624@muc.de> <200503012330.42154.bernd-schubert@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503012330.42154.bernd-schubert@web.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> stat64("/mnt/test/yp", {st_mode=S_IFDIR|0755, st_size=2704, ...}) = 0

It returns 0. No error.  Someone else in user space must be adding the EOVERFLOW.
glibc code does quite a lot of strange things with stat, perhaps
it comes from there.

> write(2, "err = -1\n", 9err = -1
> )               = 9
> write(2, "stat for /mnt/test/yp failed \n", 30stat for /mnt/test/yp failed
> ) = 30
> write(2, "ernno: 75 (Value too large for d"..., 50ernno: 75 (Value too large 
> for defined data type)
> ) = 50
> exit_group(0)                           = ?

-Andi

