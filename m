Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267543AbUH0U1C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267543AbUH0U1C (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 16:27:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267555AbUH0UMp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 16:12:45 -0400
Received: from omx1-ext.SGI.COM ([192.48.179.11]:37766 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S267405AbUH0T6r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 15:58:47 -0400
Message-ID: <412F9197.4030806@sgi.com>
Date: Fri, 27 Aug 2004 12:55:03 -0700
From: Jay Lan <jlan@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: zh-tw, en-us, en, zh-cn, zh-hk
MIME-Version: 1.0
To: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
CC: Tim Schmielau <tim@physik3.uni-rostock.de>,
       Arthur Corliss <corliss@digitalmages.com>,
       Andrew Morton <akpm@osdl.org>, Jay Lan <jlan@engr.sgi.com>,
       lkml <linux-kernel@vger.kernel.org>, erikj@dbear.engr.sgi.com,
       limin@engr.sgi.com, lse-tech@lists.sourceforge.net,
       =?ISO-8859-1?Q?Ragnar_Kj=F8rstad?= <kernel@ragnark.vestdata.no>,
       Yoshitaka ISHIKAWA <y.ishikawa@soft.fujitsu.com>
Subject: Re: [Lse-tech] Re: [PATCH] new CSA patchset for 2.6.8
References: <412D2E10.8010406@engr.sgi.com> <20040825221842.72dd83a4.akpm@osdl.org> <Pine.LNX.4.53.0408261821090.14826@gockel.physik3.uni-rostock.de> <Pine.LNX.4.58.0408261111520.22750@bifrost.nevaeh-linux.org> <Pine.LNX.4.53.0408262133190.8515@broiler.physik3.uni-rostock.de> <20040827054218.GA4142@frec.bull.fr>
In-Reply-To: <20040827054218.GA4142@frec.bull.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guillaume,

Please visit http://oss.sgi.com/projects/pagg/
The page has been updated to provide information on a per job
accounting project called 'job' based on PAGG.

There is one userspace rpm and one kernel  module for job.
This may provide what you are looking for. It is a mature product
as well. I am sure Limin(job) and Erik(pagg) would appreciate any
input you can provide to make 'job' more useful.

Regards,
  - jay


Guillaume Thouvenin wrote:
> On Thu, Aug 26, 2004 at 10:05:37PM +0200, Tim Schmielau wrote:
> 
>>It should be easy to combine the data collection enhancements from
>>CSA and ELSA to provide a common superset of information.
> 
> 
> ELSA uses current BSD accounting. The only difference with BSD is that
> accounting is done for a group of processes. I didn't use PAGG and
> rewrite something because I thought (I was wrong) that PAGG project
> wasn't maintained. I continue to maintain ELSA just because there is, 
> until today, no solution for doing job accounting. 
> So, the data collection enhancements from ELSA is not very useful.
> 
> 
>>With the new BSD acct v3 format, it should be possible to do per job
>>accounting entirely from userspace, using pid and ppid information to
>>reconstruct the process tree and some userland database for the
>>pid -> job mapping. It would, however, be greatly simplified if the
>>accounting records provided some kind of job id, and some indicator
>>whether or not this process was the last of a job (group).
> 
> 
> I like this solution.
> In fact what I proposed was to have PAGG and a modified BSD accounting
> that can be used with PAGG as both are already in the -mm tree. But
> manage group of processes from userspace is, IMHO, a better solution as
> modifications in the kernel will be minimal. 
> 
>   Therefore the solution could be to enhance BSD accounting with data
> collection from CSA and provide per job accounting with a userspace
> mechanism. Sounds great to me... 
> 
> Best,
> Guillaume
> 
> 
> -------------------------------------------------------
> SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
> 100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
> Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
> http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
> _______________________________________________
> Lse-tech mailing list
> Lse-tech@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/lse-tech

