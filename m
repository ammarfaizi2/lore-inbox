Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268898AbTCDA2a>; Mon, 3 Mar 2003 19:28:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268899AbTCDA2a>; Mon, 3 Mar 2003 19:28:30 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:30140 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S268898AbTCDA22>; Mon, 3 Mar 2003 19:28:28 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Vlad Harchev <hvv@hippo.ru>
Date: Tue, 4 Mar 2003 08:50:46 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15971.52790.676134.722437@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4 and cryptofs on raid1 - what will be cached and how many times
In-Reply-To: message from Vlad Harchev on Monday March 3
References: <20030302105634.GA4258@h>
	<20030303093832.GA4601@h>
X-Mailer: VM 7.08 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday March 3, hvv@hippo.ru wrote:
> On Sun, Mar 02, 2003 at 02:56:34PM +0400, Vlad Harchev wrote:
> > Hello, 
> > 
> > Could you please answer the following question:
> > 
> > Suppose we have a crypto filesystem on a raid1 array  of 2 devices. What will
> > the kernel cache of fileystem data contain - encrypted data or not? Will is 
> > be 2 copies of the same data in the cache or not?
> 
> Sorry for confusion - of course I meant linux software raid here..

With raid1 has no effect on caching.  Exactly the same data is cached
with raid1 as with as plain SCSI or IDE drive.

Raid5 is different.  It has an extra cache of some of the data that
has been written-to or read-from the devices.


>  
> > Is there any way to force kernel to cache the same file data only once, and
> > keep it unencrypted (in cache)?
> > 

I suspect that depends of the details of the implementation of you
"crypto filesystem".

NeilBrown
