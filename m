Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030279AbWFJEWU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030279AbWFJEWU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 00:22:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030266AbWFJEWU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 00:22:20 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:46519 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S1030237AbWFJEWT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 00:22:19 -0400
Date: Fri, 9 Jun 2006 22:22:25 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Jeff Garzik <jeff@garzik.org>
Cc: Theodore Tso <tytso@mit.edu>, "Stephen C. Tweedie" <sct@redhat.com>,
       Andrew Morton <akpm@osdl.org>, Matthew Frost <artusemrys@sbcglobal.net>,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Mingming Cao <cmm@us.ibm.com>,
       linux-fsdevel@vger.kernel.org, Alex Tomas <alex@clusterfs.com>
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
Message-ID: <20060610042224.GW5964@schatzie.adilger.int>
Mail-Followup-To: Jeff Garzik <jeff@garzik.org>,
	Theodore Tso <tytso@mit.edu>, "Stephen C. Tweedie" <sct@redhat.com>,
	Andrew Morton <akpm@osdl.org>,
	Matthew Frost <artusemrys@sbcglobal.net>,
	"ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>, Mingming Cao <cmm@us.ibm.com>,
	linux-fsdevel@vger.kernel.org, Alex Tomas <alex@clusterfs.com>
References: <1149886670.5776.111.camel@sisko.sctweedie.blueyonder.co.uk> <4489ECDD.9060307@garzik.org> <1149890138.5776.114.camel@sisko.sctweedie.blueyonder.co.uk> <448A07EC.6000409@garzik.org> <20060610004727.GC7749@thunk.org> <448A1BBA.1030103@garzik.org> <20060610013048.GS5964@schatzie.adilger.int> <448A23B2.5080004@garzik.org> <20060610022648.GV5964@schatzie.adilger.int> <448A2F1D.3030806@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <448A2F1D.3030806@garzik.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 09, 2006  22:31 -0400, Jeff Garzik wrote:
> Andreas Dilger wrote:
> >the inode count per group
> >is a fixed parameter for the whole filesystem that even online resizing
> >cannot change.
> 
> Correct.  Fixed... at mke2fs time.  Thus, with varying mke2fs runs, 
> inodes-per-group can vary, where it does not with online resize.

Unless specified differently at format time, the inodes-per-group will
be the same value (namely 16384) if the filesystem is larger than 512MB.
So, yes, I agree with you if you start with a tiny filesystem and try
to resize it to a gigantic filesystem you will get a different number
of inodes, but that is true whether this is online resizing or offline.

That said, for anyone who has resized their filesystem I think they prefer
to be able to resize it than not being able to do so at all.

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.

