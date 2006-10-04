Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161050AbWJDAvb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161050AbWJDAvb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 20:51:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161051AbWJDAvb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 20:51:31 -0400
Received: from mx1.redhat.com ([66.187.233.31]:52920 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161050AbWJDAva (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 20:51:30 -0400
Date: Tue, 3 Oct 2006 20:51:25 -0400
From: Dave Jones <davej@redhat.com>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: FSX on NFS blew up.
Message-ID: <20061004005125.GC21677@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Badari Pulavarty <pbadari@us.ibm.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Trond Myklebust <trond.myklebust@fys.uio.no>
References: <20061003164905.GD23492@redhat.com> <1159922084.9569.24.camel@dyn9047017100.beaverton.ibm.com> <20061004004009.GA20459@redhat.com> <1159922770.9569.26.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1159922770.9569.26.camel@dyn9047017100.beaverton.ibm.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2006 at 05:46:10PM -0700, Badari Pulavarty wrote:
 > On Tue, 2006-10-03 at 20:40 -0400, Dave Jones wrote:
 > > On Tue, Oct 03, 2006 at 05:34:44PM -0700, Badari Pulavarty wrote:
 > >  > On Tue, 2006-10-03 at 12:49 -0400, Dave Jones wrote:
 > >  > > Took ~8hrs to hit this on an NFSv3 mount. (2.6.18+Jan Kara's jbd patch)
 > >  > > 
 > >  > > http://www.codemonkey.org.uk/junk/fsx-nfs.txt
 > >  > 
 > >  > I was seeing *similar* problem on NFS mounted filesystem (while running
 > >  > fsx), but later realized that filesystem is full - when it happend.
 > >  > 
 > >  > Could be fsx error handling problem ? Can you check yours ?
 > > 
 > > It's running low, but there's no way it ran out. (It's down to about 4GB free).
 > > 
 > > 	Dave 
 > >  
 > 
 > Okay... Looking at your log
 > 
 > > Size error: expected 0x2b804 stat 0x37000 seek 0x37000
 > 
 > filesize doesn't match. So wondering, if you have a write
 > failure or filesystem full case.

The server didn't report anything nasty in its logs, and *touch wood*
hasn't had any hardware problems to date.

	Dave

-- 
http://www.codemonkey.org.uk
