Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315459AbSFTVN0>; Thu, 20 Jun 2002 17:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315544AbSFTVN0>; Thu, 20 Jun 2002 17:13:26 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17674 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315459AbSFTVNZ>;
	Thu, 20 Jun 2002 17:13:25 -0400
Message-ID: <3D12451C.820D3285@zip.com.au>
Date: Thu, 20 Jun 2002 14:11:56 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Gross, Mark" <mark.gross@intel.com>
CC: "'Dave Hansen'" <haveblue@us.ibm.com>,
       "'Russell Leighton'" <russ@elegant-software.com>,
       mgross@unix-os.sc.intel.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lse-tech@lists.sourceforge.net,
       "Griffiths, Richard A" <richard.a.griffiths@intel.com>
Subject: Re: [Lse-tech] Re: ext3 performance bottleneck as the number of spindles 
 gets large
References: <59885C5E3098D511AD690002A5072D3C057B49A4@orsmsx111.jf.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Gross, Mark" wrote:
> 
> ...
> The workload is http://www.coker.com.au/bonnie++/ (one of the newer versions
> ;)
>

Please tell me exactly how you're using it: how many filesystems, how
many controllers, disk topology, physical memory, size of filesystems,
etc.  Sufficient for me to be able to reproduce it and find out what
is happening.

Also: what is your best-case aggregate bandwidth?  Platter-speed of disks
multiplied by number of disks, please?

Thanks to the BKL you've effectively got 1.3 to 1.5 CPUs, but we should be
able to saturate six or eight disks on a uniprocessor kernel.  It's
possible that we're looking at the wrong thing.

-
