Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265322AbRF0MmN>; Wed, 27 Jun 2001 08:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265327AbRF0MmD>; Wed, 27 Jun 2001 08:42:03 -0400
Received: from mean.netppl.fi ([195.242.208.16]:5380 "EHLO mean.netppl.fi")
	by vger.kernel.org with ESMTP id <S265322AbRF0Mlo>;
	Wed, 27 Jun 2001 08:41:44 -0400
Date: Wed, 27 Jun 2001 15:41:40 +0300
From: Pekka Pietikainen <pp@evil.netppl.fi>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux and system area networks
Message-ID: <20010627154140.A14908@netppl.fi>
In-Reply-To: <200106261236.HAA79784@tomcat.admin.navo.hpc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3i
In-Reply-To: <200106261236.HAA79784@tomcat.admin.navo.hpc.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2001 at 07:36:30AM -0500, Jesse Pollard wrote:
> > I think you misunderstood the point.  Microsoft is providing this WSD
> > DLL as a standard part of W2K now.  This means that hardware vendors
> > just have to write a SAN service provider, and all Winsock-using
> > applications benefit transparently.  No matter how good your TCP/IP
> > implementation is, you still lose (especially in latency) compared to
> > using reliable hardware transport.  Oracle-with-VI and DAFS-vs-NFS
> > benchmarks show this quite clearly.
> 
> You do loose in security. You can't use IPSec over such a device without
> some drastic overhaul.
And the performance gains are not as obvious as one would hope, as
 there is some overhead caused by the WSD switch software
that transparently maps connections onto standard IP networks and SAN
boards depending on who you are talking to.

For some performance comparisions comparing WSD/native VI/TCP, there's
a paper called "WSDLite: a Lightweight Alternative to Windows Sockets Direct
Path", there's a link to the paper at http://citeseer.nj.nec.com/388853.html
(seems you have to use the Cached: links)

Providing a wrapper library for use with Infiniband and the current
SAN boards like WSD would probably be a useful exercise, but to really get
good performance (especially latency-wise) you probably want to use
something like MPI. For many applications a wrapper will be enough, though.
-- 
Pekka Pietikainen
