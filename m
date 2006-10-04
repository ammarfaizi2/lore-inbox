Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751233AbWJDXeK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233AbWJDXeK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 19:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751236AbWJDXeK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 19:34:10 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:49102 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751233AbWJDXeI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 19:34:08 -0400
Message-ID: <452444EF.8050406@us.ibm.com>
Date: Wed, 04 Oct 2006 16:34:07 -0700
From: Badari Pulavarty <pbadari@us.ibm.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>, Badari Pulavarty <pbadari@us.ibm.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: FSX on NFS blew up.
References: <20061003164905.GD23492@redhat.com> <1159922084.9569.24.camel@dyn9047017100.beaverton.ibm.com> <20061004004009.GA20459@redhat.com> <1159922770.9569.26.camel@dyn9047017100.beaverton.ibm.com> <20061004005125.GC21677@redhat.com>
In-Reply-To: <20061004005125.GC21677@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> On Tue, Oct 03, 2006 at 05:46:10PM -0700, Badari Pulavarty wrote:
>  > On Tue, 2006-10-03 at 20:40 -0400, Dave Jones wrote:
>  > > On Tue, Oct 03, 2006 at 05:34:44PM -0700, Badari Pulavarty wrote:
>  > >  > On Tue, 2006-10-03 at 12:49 -0400, Dave Jones wrote:
>  > >  > > Took ~8hrs to hit this on an NFSv3 mount. (2.6.18+Jan Kara's jbd patch)
>  > >  > > 
>  > >  > > http://www.codemonkey.org.uk/junk/fsx-nfs.txt
>  > >  > 
>  > >  > I was seeing *similar* problem on NFS mounted filesystem (while running
>  > >  > fsx), but later realized that filesystem is full - when it happend.
>  > >  > 
>  > >  > Could be fsx error handling problem ? Can you check yours ?
>  > > 
>  > > It's running low, but there's no way it ran out. (It's down to about 4GB free).
>  > > 
>  > > 	Dave 
>  > >  
>  > 
>  > Okay... Looking at your log
>  > 
>  > > Size error: expected 0x2b804 stat 0x37000 seek 0x37000
>  > 
>  > filesize doesn't match. So wondering, if you have a write
>  > failure or filesystem full case.
>
> The server didn't report anything nasty in its logs, and *touch wood*
> hasn't had any hardware problems to date.
>   
FWIW, On 2.6.18-mm3 I ran (4-copies) fsx on NFS mount for 24 hours
without any issues. I do see segfaults and errors when the filesystem is 
full -
those are mostly fsx error handling issues.

Thanks,
Badari

