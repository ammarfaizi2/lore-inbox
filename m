Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270652AbTHAUwo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 16:52:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270677AbTHAUwo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 16:52:44 -0400
Received: from 224.Red-217-125-129.pooles.rima-tde.net ([217.125.129.224]:18929
	"HELO cocodriloo.com") by vger.kernel.org with SMTP id S270652AbTHAUwm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 16:52:42 -0400
Date: Fri, 1 Aug 2003 23:39:53 +0200
From: Antonio Vargas <wind@cocodriloo.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Muthian S <muthian_s@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: madvise on file pages
Message-ID: <20030801213953.GA2713@wind.cocodriloo.com>
References: <Law11-F124d2VqKwRPQ00000a39@hotmail.com> <20030731153211.16c9ccb3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030731153211.16c9ccb3.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 31, 2003 at 03:32:11PM -0700, Andrew Morton wrote:
> "Muthian S" <muthian_s@hotmail.com> wrote:
> >
> > Hi,
> > 
> > Could someone inform as to what is the behavior when madvise DONTNEED is 
> > called on pages that are mmap'd from local files mapped with MAP_SHARED, 
> > i.e. they share the same page that the file cache does.
> 
> The pages are unmapped from the calling process's pagetables.  We don't
> actually free the physical pages.
> 
> > In such cases, can 
> > madvise be made to release specific pages in the file cache by mmap-ing the 
> > relevant file segment ?
> 
> No.
> 
> 2.6 kernels implement the fadvise() syscall (accessible by glibc's
> posix_fadvise() function) which will do this.

Perhaps we could send the page to the least-used end of the page lists?

-- 
winden/network

1. Dado un programa, siempre tiene al menos un fallo.
2. Dadas varias lineas de codigo, siempre se pueden acortar a menos lineas.
3. Por induccion, todos los programas se pueden
   reducir a una linea que no funciona.
