Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316798AbSE1BQw>; Mon, 27 May 2002 21:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316796AbSE1BQv>; Mon, 27 May 2002 21:16:51 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:40964 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S316793AbSE1BQu>; Mon, 27 May 2002 21:16:50 -0400
Date: Tue, 28 May 2002 03:12:36 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Colin Gibbs <colin@gibbs.dhs.org>
Cc: linux-kernel@vger.kernel.org, tcallawa@redhat.com,
        sparclinux@vger.kernel.org, aurora-sparc-devel@linuxpower.org
Subject: Re: 2.4 SRMMU bug revisited
Message-ID: <20020528011235.GA3311@louise.pinerecords.com>
In-Reply-To: <20020527092408.GD345@louise.pinerecords.com> <1022525198.19147.29.camel@monolith> <1022528045.19423.6.camel@monolith>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.99i
X-OS: GNU/Linux 2.2.21 SMP
X-Architecture: sparc
X-Uptime: 17:37
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > What kinds of heavy loads? If you were triggering the out of nocache
> > memory BUG, then this patch may help. I fixes a bug where fork fails and
> > calls destroy_context on the parent's mm or more precisely a memcpy'd
> > duplicate of it. In that case when fork returns to the parent, it
> > continuously faults.
> > 
> > But if your load does not fork heavily, then this is probably not the
> > problem.
> 
> It seems this is in the bitkeeper tree, so ignore that if you used the
> bitkeeper tree. However I'd still like to know what sort of loads are
> causing you problems.

Jup, I used the bk tree.

n=100
i=0
while [ ! "$i" = "$n" ]; do
        echo test|mail -s test user@targetmachine
        i=$(expr $i + 1)
done

targetmachine (running sendmail) goes down in under 20 seconds.

T.
