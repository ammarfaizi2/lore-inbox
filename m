Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278924AbRKFKaq>; Tue, 6 Nov 2001 05:30:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278962AbRKFKab>; Tue, 6 Nov 2001 05:30:31 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:47366 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S278924AbRKFKaQ>; Tue, 6 Nov 2001 05:30:16 -0500
Date: Tue, 6 Nov 2001 07:10:59 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Bob Smart <smart@hpc.CSIRO.AU>, Pete Wyckoff <pw@osc.edu>,
        linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: Red Hat needs this patch (was Re: handling NFSERR_JUKEBOX)
In-Reply-To: <shswv14w9ps.fsf@charged.uio.no>
Message-ID: <Pine.LNX.4.21.0111060709380.9597-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 6 Nov 2001, Trond Myklebust wrote:

> >>>>> " " == Bob Smart <smart@hpc.CSIRO.AU> writes:
> 
>     >> Take a look at the nfs sourceforge mailing list.  There's a
>     >> long thread about this in the context of a Solaris HSM server.
>     >> I wrote a patch to try to do the right thing on a linux client,
>     >> but it is not perfect for many reasons:
>     >> http://devrandom.net/lists/archives/2001/6/NFS/0135.html
> 
>      > Thanks again for this patch. I've appended our current version
>      > to save others the trouble of minor modifications. I've just
>      > tested it against 2.4.13-ac7.
> 
>      > Your patch may not be perfect but it is a million times better
>      > than nothing. We have had no problems with it. Linux has a long
>      > tradition of utilizing imperfect software till something better
>      > comes along.
> 
>      > This patch is ESSENTIAL to make Linux useable in large
>      > enterprises, because they increasingly commonly utilize
>      > hirearchically managed storage. I strongly urge
>      > Alan/Linus/Macello to include this patch in the stable kernel
>      > tree (but marked experimental). Or at least can the kernel
>      > maintainers at Red Hat and other distributions put it in their
>      > offerings: surely you see that you need this for your big
>      > customers.
> 
> The patch may appear to work, but it fails to understand the nature of
> the problem. The problem with NFSERR_JUKEBOX is that is can appear in
> more or less *any* NFSv3 RPC call. That includes everything from
> lookups to writes.
> 
> If all you do is intercept read and setattr, then you certainly
> haven't achieved 'enterprise quality'.

Trond, 

Should'nt we make Linux retry on NFSERR_JUKEBOX _by default_ ? 

Is there any reason why we already don't do that already except "nobody
coded it yet" ? 

