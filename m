Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313079AbSC0TNm>; Wed, 27 Mar 2002 14:13:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313078AbSC0TNc>; Wed, 27 Mar 2002 14:13:32 -0500
Received: from gw.wmich.edu ([141.218.1.100]:43678 "EHLO gw.wmich.edu")
	by vger.kernel.org with ESMTP id <S313079AbSC0TNT>;
	Wed, 27 Mar 2002 14:13:19 -0500
Subject: Re: [patch] speed up ext3 synchronous mounts
From: Ed Sweetman <ed.sweetman@wmich.edu>
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20020327190731.GA12677@merlin.emma.line.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 27 Mar 2002 14:13:10 -0500
Message-Id: <1017256395.517.1.camel@psuedomode>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-03-27 at 14:07, Matthias Andree wrote:
> On Sun, 24 Mar 2002, Andrew Morton wrote:
> 
> > Again, we don't need to sync indirects as we dirty them because
> > we run a commit if IS_SYNC(inode) prior to returning to the
> > caller of write(2).
> 
> Will this help synchronous NFS writes, at least a little? I have slow
> write performance on "sync" NFSv3 exports (ext3 underneath, you guessed
> it), kernel 2.4.19-pre3-ac4 (not really surprising, sync is slow ;-). Is
> it worth a try?

if you look at the source.  that kernel doesn't need the patch. Seems to
have already been applied since ac1


> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


