Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265635AbTFNHrn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 03:47:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265636AbTFNHrn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 03:47:43 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:54730 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S265635AbTFNHrm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 03:47:42 -0400
Date: Sat, 14 Jun 2003 01:01:39 -0700
From: Andrew Morton <akpm@digeo.com>
To: Mingming Cao <cmm@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.70-mm9
Message-Id: <20030614010139.2f0f1348.akpm@digeo.com>
In-Reply-To: <3EEAD41B.2090709@us.ibm.com>
References: <20030613013337.1a6789d9.akpm@digeo.com>
	<3EEAD41B.2090709@us.ibm.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Jun 2003 08:01:31.0287 (UTC) FILETIME=[2A76CA70:01C3324B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mingming Cao <cmm@us.ibm.com> wrote:
>
> Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.70/2.5.70-mm9/
> > 
> > 
> > Lots of fixes, lots of new things.
> >
> 
> Good news, Andrew. I run 50 fsx tests on ext3 filesystems on 2.5.70-mm9. 
>    The hang problem I used seen on 2.5.70-mm6 kernel is gone. The tests 
> runs fine for more than 9 hours. (Normally the problem will occur after 
> 7 hours run on 2.5.70-mm6 kernel).

OK.  I'm no statistician, but I'd be more comfortable with 24 hours..

> I am running the tests on 8 way PIII 700MHz, 4G memory, with 
> elevator=deadline.
> 

Was elevator=deadline observed to fail in earlier kernels?  If not then it
may be an anticipatory scheduler bug.  It certainly had all the appearances
of that.

So once you're really sure that elevator=deadline isn't going to fail,
could you please test elevator=as?


