Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278100AbRJRTil>; Thu, 18 Oct 2001 15:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278102AbRJRTid>; Thu, 18 Oct 2001 15:38:33 -0400
Received: from atlrel6.hp.com ([192.151.27.8]:40969 "HELO atlrel6.hp.com")
	by vger.kernel.org with SMTP id <S278100AbRJRTi2>;
	Thu, 18 Oct 2001 15:38:28 -0400
Message-ID: <C5C45572D968D411A1B500D0B74FF4A80418D57F@xfc01.fc.hp.com>
From: "DICKENS,CARY (HP-Loveland,ex2)" <cary_dickens2@hp.com>
To: "'Andrew Morton'" <akpm@zip.com.au>,
        "DICKENS,CARY (HP-Loveland,ex2)" <cary_dickens2@hp.com>
Cc: "Kernel Mailing List (E-mail)" <linux-kernel@vger.kernel.org>,
        "HABBINGA,ERIK (HP-Loveland,ex1)" <erik_habbinga@hp.com>
Subject: RE: Kernel performance in reference to 2.4.5pre1
Date: Thu, 18 Oct 2001 15:38:54 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'll put this on my priority list to look into.  When I get the numbers,
I'll squeak again.

Thanks, 
Cary

> -----Original Message-----
> From: Andrew Morton [mailto:akpm@zip.com.au]
> Sent: Thursday, October 18, 2001 12:34 PM
> To: DICKENS,CARY (HP-Loveland,ex2)
> Cc: Kernel Mailing List (E-mail); HABBINGA,ERIK (HP-Loveland,ex1)
> Subject: Re: Kernel performance in reference to 2.4.5pre1
> 
> 
> "DICKENS,CARY (HP-Loveland,ex2)" wrote:
> > 
> > 2.4.5pre1 is the base for comparison,
> > 
> > [ figures showing that more recent kernels suck ]
> > 
> 
> SFS is a rather specialised workload, and synchronous NFS exports
> are not a thing which gets a lot of attention.  It could be one
> small, hitherto unnoticed change which caused this performance
> regression.  And it appears that the change occurred between 2.4.5
> and 2.4.7.
> 
> We don't know whether this slowdown is caused by changes in the VM,
> the filesystem, the block device layer, nfsd or networking. 
> For example,
> ksoftirqd was introduced between 2.4.5 and 2.4.7.  Could it be that?
> 
> For all these reasons it would be really helpful if you could
> go back and test the 2.4.6-preX and 2.4.7-preX kernels (binary search)
> and tell us if there was a particular release which caused 
> this decrease in
> throughput.
> 
> If it can be pinned down to a particular patch then there's a good
> chance that it can be fixed.
> 
