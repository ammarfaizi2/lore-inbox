Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263784AbUIINjZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263784AbUIINjZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 09:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263795AbUIINjZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 09:39:25 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:44177 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263784AbUIINjX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 09:39:23 -0400
Date: Wed, 8 Sep 2004 23:14:09 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Ray Bryant <raybry@sgi.com>
Cc: Con Kolivas <kernel@kolivas.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org, riel@redhat.com,
       piggin@cyberone.com.au, mbligh@aracnet.com
Subject: Re: swapping and the value of /proc/sys/vm/swappiness
Message-ID: <20040909021409.GA2122@logos.cnet>
References: <cone.1094512172.450816.6110.502@pc.kolivas.org> <20040906162740.54a5d6c9.akpm@osdl.org> <cone.1094513660.210107.6110.502@pc.kolivas.org> <20040907000304.GA8083@logos.cnet> <20040907212051.GC3492@logos.cnet> <413F1518.7050608@sgi.com> <20040908165412.GB4284@logos.cnet> <413F5EE7.6050705@sgi.com> <20040908193036.GH4284@logos.cnet> <413FC8AC.7030707@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <413FC8AC.7030707@sgi.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 08, 2004 at 10:06:20PM -0500, Ray Bryant wrote:
> Marcelo,
> 
> For what it is worth, here are the benchmark results for the kernel with 
> the patch I discussed before, along with the previous 2.6.9-rc1-mm3 results:
> 
> Kernel Version 2.6.9-rc1-mm3:
>         Total I/O   Avg Swap   min    max     pg cache    min    max
>        ----------- --------- ------- ------  --------- ------- -------
>    0   274.80 MB/s  10511 MB (  5644, 14492)  13293 MB (  8596, 17156)
>   20   267.02 MB/s  12624 MB (  5578, 16287)  15298 MB (  8468, 18889)
>   40   267.66 MB/s  13541 MB (  6619, 17461)  16199 MB (  9393, 20044)
>   60   233.73 MB/s  18094 MB ( 16550, 19676)  20629 MB ( 19103, 22192)
>   80   213.64 MB/s  20950 MB ( 15844, 22977)  23450 MB ( 18496, 25440)
>  100   164.58 MB/s  26004 MB ( 26004, 26004)  28410 MB ( 28327, 28455)
> 
> Kernel Version 2.6.9-rc1-mm3-kdb-nrmap:
>         Total I/O   Avg Swap   min    max     pg cache    min    max
>        ----------- --------- ------- ------  --------- ------- -------
>    0   286.93 MB/s   7288 MB (  4847, 14536)  10122 MB (  7771, 17138)
>   20   252.43 MB/s  13305 MB (  3950, 18337)  15938 MB (  6866, 20876)
>   40   268.52 MB/s  11538 MB (  5333, 17298)  14238 MB (  8247, 19836)
>   60   242.72 MB/s  16367 MB (  8652, 21217)  18909 MB ( 11514, 23561)
>   80   212.94 MB/s  19424 MB (  5632, 24047)  21937 MB (  8567, 26469)
>  100   161.66 MB/s  26006 MB ( 26004, 26007)  28445 MB ( 28407, 28471)
> 
> Except for the swappiness = 20 case, things are a smallish bit better for
> the modified kernel than 2.6.9-rc1-mm3.  Clearly we haven't found the root 
> of this problem yet.

Indeed.

> Have you still been unable to duplicate this problem on a small i386 
> platform?

Yes right, I have been unable to duplicate the problem on small i386 box. 
What about your tests?


