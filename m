Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269319AbTCDHyK>; Tue, 4 Mar 2003 02:54:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269321AbTCDHyK>; Tue, 4 Mar 2003 02:54:10 -0500
Received: from [195.128.145.236] ([195.128.145.236]:29312 "EHLO hippo.ru")
	by vger.kernel.org with ESMTP id <S269319AbTCDHyI>;
	Tue, 4 Mar 2003 02:54:08 -0500
Date: Tue, 4 Mar 2003 13:30:20 +0400
From: Vlad Harchev <hvv@hippo.ru>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4 and cryptofs on raid1 - what will be cached and how many times
Message-ID: <20030304093020.GA4024@h>
References: <20030302105634.GA4258@h> <20030303093832.GA4601@h> <15971.52790.676134.722437@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15971.52790.676134.722437@notabene.cse.unsw.edu.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 04, 2003 at 08:50:46AM +1100, Neil Brown wrote:
> On Monday March 3, hvv@hippo.ru wrote:
> > On Sun, Mar 02, 2003 at 02:56:34PM +0400, Vlad Harchev wrote:
> > > Hello, 
> > > 
> > > Could you please answer the following question:
> > > 
> > > Suppose we have a crypto filesystem on a raid1 array  of 2 devices. What will
> > > the kernel cache of fileystem data contain - encrypted data or not? Will is 
> > > be 2 copies of the same data in the cache or not?
> > 
> > Sorry for confusion - of course I meant linux software raid here..
> 
> With raid1 has no effect on caching.  Exactly the same data is cached
> with raid1 as with as plain SCSI or IDE drive.

 The question I asked is - will under the active usage there be exactly one
copy of a file's data, or there will be N (where N is number of disks in raid1
array) copies in the cache? I.e. how optimal caching is performed?
 
> Raid5 is different.  It has an extra cache of some of the data that
> has been written-to or read-from the devices.

 OK, thank you for pointing this.
 
> 
> >  
> > > Is there any way to force kernel to cache the same file data only once, and
> > > keep it unencrypted (in cache)?
> > > 
> 
> I suspect that depends of the details of the implementation of you
> "crypto filesystem".

 Sorry for confusion - I meant loopback-based crypto filesystem - e.g. loop-aes
based (loop-aes.sourceforge.net) or CryptoAPI-based (www.kerneli.org) - both
are loopback-based filesystem (one has to call losetup(8) to point out chipher,
a password..) I'm getting an impression that the kernel cache will contain
encrypted data in case loopback-based crypto filesystems are used just 
observing performance..

Thank you for the anwser!
-- 
 Best regards,
  -Vlad
