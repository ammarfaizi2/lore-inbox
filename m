Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263667AbUCZDlI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 22:41:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263917AbUCZDlI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 22:41:08 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:27127 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S263667AbUCZDlB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 22:41:01 -0500
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: suparna@in.ibm.com
Cc: Andrew Morton <akpm@osdl.org>, apw@shadowen.org, anton@samba.org,
       sds@epoch.ncsc.mil, ak@suse.de, raybry@sgi.com,
       lse-tech@lists.sourceforge.net, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, mbligh@aracnet.com
Subject: Re: [Lse-tech] Re: [PATCH] [0/6] HUGETLB memory commitment 
In-reply-to: Your message of "Fri, 26 Mar 2004 14:28:26 +0530."
             <20040326085826.GA3332@in.ibm.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 26 Mar 2004 14:39:09 +1100
Message-ID: <5310.1080272349@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Mar 2004 14:28:26 +0530, 
Suparna Bhattacharya <suparna@in.ibm.com> wrote:
>On Thu, Mar 25, 2004 at 04:22:32PM -0800, Andrew Morton wrote:
>> Keith Owens <kaos@sgi.com> wrote:
>> >
>> > FWIW, lkcd (crash dump) treats hugetlb pages as normal kernel pages and
>> > dumps them, which is pointless and wastes a lot of time.  To avoid
>> > dumping these pages in lkcd, I had to add a PG_hugetlb flag.  lkcd runs
>
>This should already be fixed in recent versions of lkcd. It uses a
>little bit of trickery to avoid an extra page flag -- hugetlb pages are 
>detected as "in use" as well as reserved, unlike other reserved pages 
>which helps identify them.

Are you sure that this works for hugetlb pages that have been
preallocated but not yet mapped?  AFAICT the hugetlb pages start off as
reserved with a zero usecount.

