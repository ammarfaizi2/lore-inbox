Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291942AbSBATtl>; Fri, 1 Feb 2002 14:49:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291949AbSBATtW>; Fri, 1 Feb 2002 14:49:22 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:15270 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S291951AbSBATry>;
	Fri, 1 Feb 2002 14:47:54 -0500
Date: Fri, 1 Feb 2002 14:47:51 -0500
From: Jeff Garzik <garzik@havoc.gtf.org>
To: arjan@fenrus.demon.nl
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Radix-tree pagecache for 2.5
Message-ID: <20020201144751.A32553@havoc.gtf.org>
In-Reply-To: <20020201132953.A27508@havoc.gtf.org> <m16Wig6-000OVeC@amadeus.home.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <m16Wig6-000OVeC@amadeus.home.nl>; from arjan@fenrus.demon.nl on Fri, Feb 01, 2002 at 06:44:50PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2002 at 06:44:50PM +0000, arjan@fenrus.demon.nl wrote:
> In article <20020201132953.A27508@havoc.gtf.org> you wrote:
> > On Fri, Feb 01, 2002 at 09:06:37AM -0800, Linus Torvalds wrote:
> >> Even databases often use multiple files, and quite frankly, a database
> >> that doesn't use mmap and doesn't try very hard to not cause extra system
> >> calls is going to be bad performance-wise _regardless_ of any page cache
> >> locking.
> 
> > I've always thought that read(2) and write(2) would in the end wind up
> > faster than mmap(2)...  Tests in my rewritten cp/rm/mv type utilities
> > seem to bear this out.
> 
> the biggest reason for this is that we *suck* at readahead for mmap....

Is there not also fault overhead and similar issues related to mmap(2)
in general, that are not present with read(2)/write(2)?

	Jeff



