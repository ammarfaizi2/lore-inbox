Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030561AbWFIXy4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030561AbWFIXy4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 19:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030555AbWFIXy4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 19:54:56 -0400
Received: from thunk.org ([69.25.196.29]:49042 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1030396AbWFIXyz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 19:54:55 -0400
Date: Fri, 9 Jun 2006 19:54:42 -0400
From: Theodore Tso <tytso@mit.edu>
To: Jeff Garzik <jeff@garzik.org>, Alex Tomas <alex@clusterfs.com>,
       Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       cmm@us.ibm.com, linux-fsdevel@vger.kernel.org,
       Andreas Dilger <adilger@clusterfs.com>
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
Message-ID: <20060609235442.GB20605@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Jeff Garzik <jeff@garzik.org>, Alex Tomas <alex@clusterfs.com>,
	Andrew Morton <akpm@osdl.org>,
	ext2-devel <ext2-devel@lists.sourceforge.net>,
	linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
	cmm@us.ibm.com, linux-fsdevel@vger.kernel.org,
	Andreas Dilger <adilger@clusterfs.com>
References: <m3k67qb7hr.fsf@bzzz.home.net> <4489A7ED.8070007@garzik.org> <20060609195750.GD10524@thunk.org> <20060609203803.GF3574@ca-server1.us.oracle.com> <20060609210319.GF10524@thunk.org> <20060609212410.GJ3574@ca-server1.us.oracle.com> <20060609215137.GG10524@thunk.org> <20060609220711.GA29684@ca-server1.us.oracle.com> <20060609223129.GI10524@thunk.org> <20060609224700.GB29684@ca-server1.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060609224700.GB29684@ca-server1.us.oracle.com>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2006 at 03:47:00PM -0700, Joel Becker wrote:
> 	What happens today if you have a filesystem in fstab that
> has no fsck in /sbin (eg, we all pick the name 'ext4', it says 'ext4' in
> fstab, but there is no /sbin/fsck.ext4)?  Does "fsck -a" skip the
> partition, or halt and fail the boot?  If the latter, I suspect that the
> only solution is "I hope you don't encounter this on remote machines ha
> ha ha".  

It will halt and fail the boot.

Of course, installing a kernel more recent on 2.6.14 or so a RHEL4
system when you have a SCSI controller such as MPT Fusion will also
cause the system to fail to boot unless you remember to compile it
directly into the kernel because of changes in semantics about whether
the SCSI probing happens before or after the module load completes ---
and the answer that has been given is "we don't care".  So these sorts
of traps have been around for people who are going back and forth
between the bleeding edge and distro systems, but I think we'd all
agree that this isn't necessarily the common case.

							- Ted
