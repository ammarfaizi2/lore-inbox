Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129078AbRBALUq>; Thu, 1 Feb 2001 06:20:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129080AbRBALUf>; Thu, 1 Feb 2001 06:20:35 -0500
Received: from oxmail3.ox.ac.uk ([129.67.1.180]:5507 "EHLO oxmail.ox.ac.uk")
	by vger.kernel.org with ESMTP id <S129078AbRBALUW>;
	Thu, 1 Feb 2001 06:20:22 -0500
Date: Thu, 1 Feb 2001 11:20:15 +0000
From: Malcolm Beattie <mbeattie@sable.ox.ac.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [UPDATE] Fresh zerocopy patch on kernel.org
Message-ID: <20010201112014.A27009@sable.ox.ac.uk>
In-Reply-To: <14966.35438.429963.405587@pizda.ninka.net> <20010131152653.C13345@sable.ox.ac.uk> <14968.49462.674977.825098@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <14968.49462.674977.825098@pizda.ninka.net>; from davem@redhat.com on Wed, Jan 31, 2001 at 05:51:50PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller writes:
> 
> Malcolm Beattie writes:
>  > David S. Miller writes:
>  > > 
>  > > At the usual place:
>  > > 
>  > > ftp://ftp.kernel.org/pub/linux/kernel/people/davem/zerocopy-2.4.1-1.diff.gz
>  > 
>  > Hmm, disappointing results here; maybe I've missed something.
> 
> As discussed elsewhere there is a %10 to %15 performance hit for
> normal write()'s done with the new code.
> 
> If you do your testing using sendfile() as the data source, you'll
> results ought to be wildly different and more encouraging.

I did say that the ftp test used sendfile() as the data source and
it dropped from 86 MB/s to 62 MB/s. Alexey has mailed me suggesting
the problem may be that netfilter is turned on. It is indeed turned
on in both the 2.4.1 config and the 2.4.1+zc config but maybe it has
a far higher detrimental effect in the zerocopy case. I'm currently
building new non-netfilter kernels and I'll go through the exercise
again. I'm confident I'll end up being impressed with the numbers
even if it takes some tweaking to get there :-)

--Malcolm

-- 
Malcolm Beattie <mbeattie@sable.ox.ac.uk>
Unix Systems Programmer
Oxford University Computing Services
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
