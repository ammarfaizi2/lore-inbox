Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319278AbSHNULu>; Wed, 14 Aug 2002 16:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319279AbSHNULu>; Wed, 14 Aug 2002 16:11:50 -0400
Received: from mailrelay2.lanl.gov ([128.165.4.103]:63681 "EHLO
	mailrelay2.lanl.gov") by vger.kernel.org with ESMTP
	id <S319278AbSHNULt>; Wed, 14 Aug 2002 16:11:49 -0400
Subject: Re: Performance differences for recent kernels running forky test.
From: Steven Cole <elenstev@mesatop.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3D5AB120.BB7700AB@zip.com.au>
References: <1029352630.14756.140.camel@spc9.esa.lanl.gov> 
	<3D5AB120.BB7700AB@zip.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 14 Aug 2002 14:12:46 -0600
Message-Id: <1029355966.14756.147.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-08-14 at 13:36, Andrew Morton wrote:
> Steven Cole wrote:
> > 
> > I ran the following lots_of_forks.sh script for several kernels.
> > 
> > http://people.nl.linux.org/~phillips/patches/lots_of_forks.sh
> > 
> > ...
> >         2.4.20-pre2     2.4.20-pre2-ac1 2.5.28          2.5.31
> > 
> > 1       24.96           53.18           39.91           37.04
> > 2       24.92           52.42           44.91           45.88
> > 3       24.69           50.69           48.63           44.89
> > 4       24.39           51.9            58.12           55.8
> > 5       24.72           46.14           49.81           43.18
> > 6       24.34           47.99           57.62           40.93
> > 7       24.64           52.33           50.42           47.27
> > 8       24.53           52.84           45              36.49
> > 
> 
> That's the page_add_rmap/page_remove_rmap thing.  Could you retest
> 2.5.31 with
> http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.31/stuff-sent-to-linus/everything.gz
> applied?

Yes, here are the results:

	2.5.31-vanilla	2.5.31-akpm-all
1		37.04		35.98
2		45.88		36.94
3		44.89		35.23
4		55.8		38.49
5		43.18		51.43
6		40.93		46.3
7		47.27		46.94
8		36.49		47.19

Steven

