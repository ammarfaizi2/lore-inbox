Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319199AbSHGTAv>; Wed, 7 Aug 2002 15:00:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319200AbSHGTAv>; Wed, 7 Aug 2002 15:00:51 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17415 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S319199AbSHGTAu>;
	Wed, 7 Aug 2002 15:00:50 -0400
Message-ID: <3D516EB5.E8669146@zip.com.au>
Date: Wed, 07 Aug 2002 12:02:14 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Ravikiran G Thirumalai <kiran@in.ibm.com>, linux-kernel@vger.kernel.org,
       lse <lse-tech@lists.sourceforge.net>,
       Rik van Riel <riel@conectiva.com.br>
Subject: Re: [Lse-tech] [patch] Scalable statistics counters with /proc reporting
References: <20020807142227.B12301@in.ibm.com> <20020807100216.A27321@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> 
> ...
> Also the /proc-based implementation is really ugly.  It should be moved
> over to the seq_file interface at least, a simple ramfs-style own
> filesystem ("stats" filesystem type) would be the cleanest solution.

I'd suggest that it be just a single stat counter per /proc
file.  A simple sprintf is fine for that.

If it's necessary to write a new filesystem to just export a bunch
of integers to userspace then something is seriously wrong.
