Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278911AbRKSN6R>; Mon, 19 Nov 2001 08:58:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278959AbRKSN6I>; Mon, 19 Nov 2001 08:58:08 -0500
Received: from mta.sara.nl ([145.100.16.144]:51875 "EHLO mta.sara.nl")
	by vger.kernel.org with ESMTP id <S278911AbRKSN5x>;
	Mon, 19 Nov 2001 08:57:53 -0500
Message-Id: <200111191357.OAA04801@zhadum.sara.nl>
X-Mailer: exmh version 2.1.1 10/15/1999
From: Remco Post <r.post@sara.nl>
To: James A Sutherland <jas88@cam.ac.uk>
cc: Roy Sigurd Karlsbakk <roy@karlsbakk.net>, linux-kernel@vger.kernel.org
Subject: Re: swap? 
In-Reply-To: Message from James A Sutherland <jas88@cam.ac.uk> 
   of "Mon, 19 Nov 2001 13:42:54 GMT." <E165ohF-0006WW-00@mauve.csi.cam.ac.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 19 Nov 2001 14:57:46 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Monday 19 November 2001 12:46 am, Roy Sigurd Karlsbakk wrote:
> > What about a tux-only system?
> >
> > should I disable swap?
> 
> No, probably not. Having some swapspace (or, to keep the .nl pedant happy, 
> "pagespace") available will allow the kernel to migrate unused pages to disk, 
> making more room available for caching of your WWW site's content. Being part 
> of the kernel, Tux's code will all be locked in memory anyway; the rest of 
> free RAM will be used for caching content.
> 
> 
> James.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

On a tux only system, you'll have very little data that is not on a 
filesystem. Since all other applications running (you'll wind up with at least 
20 or so processes like syslogd...) are very small, and those will use very 
little data-pages, you'll probably see no benefit from having a swappartition. 
Having enough RAM to be used as a buffer-cache seems more usefull. Unused 
code-pages of userland apps will be discarded anyway. Leaving you with more 
memory to be used as a buffer-cache.

-- 
Met vriendelijke groeten,

Remco Post

SARA - Stichting Academisch Rekencentrum Amsterdam
High Performance Computing  Tel. +31 20 592 8008    Fax. +31 20 668 3167

"I really didn't foresee the Internet. But then, neither did the computer
industry. Not that that tells us very much of course - the computer industry
didn't even foresee that the century was going to end." -- Douglas Adams


