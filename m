Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289372AbSAJKT6>; Thu, 10 Jan 2002 05:19:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289373AbSAJKTs>; Thu, 10 Jan 2002 05:19:48 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:30736 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S289372AbSAJKTh>; Thu, 10 Jan 2002 05:19:37 -0500
Date: Thu, 10 Jan 2002 11:18:25 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Benjamin LaHaise <bcrl@redhat.com>, linux-kernel@vger.kernel.org,
        marcelo@conectiva.com.br
Subject: Re: [PATCH] PAGE_SIZE IO for RAW (RAW VARY)
Message-ID: <20020110111825.C3357@inspiron.school.suse.de>
In-Reply-To: <20020109132148.C12609@redhat.com> <200201091928.g09JSdH23535@eng2.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <200201091928.g09JSdH23535@eng2.beaverton.ibm.com>; from pbadari@us.ibm.com on Wed, Jan 09, 2002 at 11:28:39AM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2002 at 11:28:39AM -0800, Badari Pulavarty wrote:
> Ben,
> 
> By any chance do you have a list of drivers that assume this ? 
> What does it take to fix them ? 
> 
> I think Jens BIO changes for 2.5 will fix this problem. But 
> 2.4 needs a solution in this area too. This patch showed 
> significant improvement for database workloads. 

I didn't checked the implementation but as far as the blkdev is
concerned the b_size changes without notification as soon as you 'mkfs
-b somethingelse' and then mount the fs. So it cannot break as far I can
tell. The only important thing is that b_size stays between 512 and 4k.

> If it is not reasonable to fix all the brokern drivers,
> how about making this configurable (to do variable size IO) ?
> Do you favour this solution ?

no.

Andrea
