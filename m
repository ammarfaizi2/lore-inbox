Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315300AbSFOMXb>; Sat, 15 Jun 2002 08:23:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315334AbSFOMXa>; Sat, 15 Jun 2002 08:23:30 -0400
Received: from ns.suse.de ([213.95.15.193]:35600 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S315300AbSFOMX3>;
	Sat, 15 Jun 2002 08:23:29 -0400
Date: Sat, 15 Jun 2002 14:23:30 +0200
From: Dave Jones <davej@suse.de>
To: Brent Cook <busterb@mail.utexas.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: File permission problem with NFSv3 and 2.5.20-dj4
Message-ID: <20020615142330.C16772@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Brent Cook <busterb@mail.utexas.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0202072243560.26015-100000@Appserv.suse.de> <20020614171820.A13031-100000@abbey.hauschen>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 14, 2002 at 05:30:01PM -0500, Brent Cook wrote:

 >   Looks like there is a problem with NFSv3 and file permissions in the DJ
 > kernels.
 > 
 > A file that is marked as executable will lose its executable flag whenever
 > it is written to. I suspect the proble lies in the changes to the NFS file
 > info cacheing in the DJ kernels at least since 2.5.20-dj1 (I was unable
 > to find where this change occured in the changelog).

The NFS changes need going over. I'll see whats left after backing out
Trond's READDIRPLUS patch. I'm expecting it to be just some small bits
like BKL shifting around, but that shouldn't be causing the problems
you saw..

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
