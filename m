Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314783AbSFTQY6>; Thu, 20 Jun 2002 12:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315167AbSFTQY5>; Thu, 20 Jun 2002 12:24:57 -0400
Received: from chfdns02.ch.intel.com ([143.182.246.25]:50160 "EHLO
	melete.ch.intel.com") by vger.kernel.org with ESMTP
	id <S314783AbSFTQY4>; Thu, 20 Jun 2002 12:24:56 -0400
Message-ID: <59885C5E3098D511AD690002A5072D3C057B49A4@orsmsx111.jf.intel.com>
From: "Gross, Mark" <mark.gross@intel.com>
To: "'Dave Hansen'" <haveblue@us.ibm.com>,
       "Gross, Mark" <mark.gross@intel.com>
Cc: "'Russell Leighton'" <russ@elegant-software.com>,
       Andrew Morton <akpm@zip.com.au>, mgross@unix-os.sc.intel.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lse-tech@lists.sourceforge.net,
       "Griffiths, Richard A" <richard.a.griffiths@intel.com>
Subject: RE: [Lse-tech] Re: ext3 performance bottleneck as the number of s
	pindles gets large
Date: Thu, 20 Jun 2002 09:24:54 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm don't have much visibility into this platform's journaling requirements.
I suspect its to enable fast reboot / recovery from some klutz bumping the
power cord or a crash of some sort.

I will raise the issue with the platform folks.  However; for now I'm
looking for ways to make it scale competitively WRT adapters and spindles
for writes without changing the file system.  If this turns out to be a dead
end then, hopefully, we'll move to a more spindle friendly file system.

The workload is http://www.coker.com.au/bonnie++/ (one of the newer versions
;)

--mgross

(W) 503-712-8218
MS: JF1-05
2111 N.E. 25th Ave.
Hillsboro, OR 97124


> -----Original Message-----
> From: Dave Hansen [mailto:haveblue@us.ibm.com]
> Sent: Thursday, June 20, 2002 9:10 AM
> To: Gross, Mark
> Cc: 'Russell Leighton'; Andrew Morton; mgross@unix-os.sc.intel.com;
> Linux Kernel Mailing List; lse-tech@lists.sourceforge.net; Griffiths,
> Richard A
> Subject: Re: [Lse-tech] Re: ext3 performance bottleneck as 
> the number of
> spindles gets large
> 
> 
> Gross, Mark wrote:
> > We will get around to reformatting our spindles to some 
> other FS after 
> > we get as much data and analysis out of our current 
> configuration as we 
> > can get. 
> >  
> > We'll report out our findings on the lock contention, and 
> throughput 
> > data for some other FS then.  I'd like recommendations on what file 
> > systems to try, besides ext2.
> 
> Do you really need a journaling FS?  If not, I think ext2 is a sure 
> bet to be the fastest.  If you do need journaling, try 
> reiserfs and jfs.
> 
> BTW, what kind of workload are you running under?
> 
> -- 
> Dave Hansen
> haveblue@us.ibm.com
> 
