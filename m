Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278788AbRKFJGD>; Tue, 6 Nov 2001 04:06:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278709AbRKFJFx>; Tue, 6 Nov 2001 04:05:53 -0500
Received: from pat.uio.no ([129.240.130.16]:49631 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S278879AbRKFJFv>;
	Tue, 6 Nov 2001 04:05:51 -0500
To: Bob Smart <smart@hpc.CSIRO.AU>
Cc: Pete Wyckoff <pw@osc.edu>, linux-kernel@vger.kernel.org,
        alan@lxorguk.ukuu.org.uk
Subject: Re: Red Hat needs this patch (was Re: handling NFSERR_JUKEBOX)
In-Reply-To: <200111060521.QAA07024@trout.hpc.CSIRO.AU>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 06 Nov 2001 10:05:19 +0100
In-Reply-To: <200111060521.QAA07024@trout.hpc.CSIRO.AU>
Message-ID: <shswv14w9ps.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Bob Smart <smart@hpc.CSIRO.AU> writes:

    >> Take a look at the nfs sourceforge mailing list.  There's a
    >> long thread about this in the context of a Solaris HSM server.
    >> I wrote a patch to try to do the right thing on a linux client,
    >> but it is not perfect for many reasons:
    >> http://devrandom.net/lists/archives/2001/6/NFS/0135.html

     > Thanks again for this patch. I've appended our current version
     > to save others the trouble of minor modifications. I've just
     > tested it against 2.4.13-ac7.

     > Your patch may not be perfect but it is a million times better
     > than nothing. We have had no problems with it. Linux has a long
     > tradition of utilizing imperfect software till something better
     > comes along.

     > This patch is ESSENTIAL to make Linux useable in large
     > enterprises, because they increasingly commonly utilize
     > hirearchically managed storage. I strongly urge
     > Alan/Linus/Macello to include this patch in the stable kernel
     > tree (but marked experimental). Or at least can the kernel
     > maintainers at Red Hat and other distributions put it in their
     > offerings: surely you see that you need this for your big
     > customers.

The patch may appear to work, but it fails to understand the nature of
the problem. The problem with NFSERR_JUKEBOX is that is can appear in
more or less *any* NFSv3 RPC call. That includes everything from
lookups to writes.

If all you do is intercept read and setattr, then you certainly
haven't achieved 'enterprise quality'.

Cheers,
   Trond
