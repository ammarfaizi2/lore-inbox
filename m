Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265592AbUAHX76 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 18:59:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265125AbUAHX6z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 18:58:55 -0500
Received: from crosslink-village-512-1.bc.nu ([81.2.110.254]:33158 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S265117AbUAHX6m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 18:58:42 -0500
Subject: Re: [Dri-devel] 2.6.1-rc2-mm1: drm/sis_mm.c compile error
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Andrew Morton <akpm@osdl.org>, DRI Devel <dri-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040108153656.GF13867@fs.tum.de>
References: <20040107232831.13261f76.akpm@osdl.org>
	 <20040108153656.GF13867@fs.tum.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1073606068.13007.72.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 08 Jan 2004 23:54:31 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-01-08 at 15:36, Adrian Bunk wrote:
> On Wed, Jan 07, 2004 at 11:28:31PM -0800, Andrew Morton wrote:
> >...
> > - Added the latest code drop from DRM CVS.  People who use DRM, please test
> >   it.
> >...
> 
> I got the following compile error:

I got it to crash the kernel. Build with no sis_fb compiled in, hack the
dri userspace (client non priviledged code) to pass random numbers to
FB_ALLOC/FREE and it oopses.

The checks in the sis_drm for which memory allocator to use also come
out with bogus answers for some module/non-module combinations. Probably
the sis_mm one should be a seperate module since the alternate mm in the
4.3.99x DRM seems exploitable and insufficiently sanity checked.

Alan

