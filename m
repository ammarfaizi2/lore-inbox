Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030559AbWFIWJd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030559AbWFIWJd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 18:09:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030555AbWFIWJd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 18:09:33 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:24405 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1030341AbWFIWJb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 18:09:31 -0400
Date: Fri, 9 Jun 2006 15:07:11 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Theodore Tso <tytso@mit.edu>, Jeff Garzik <jeff@garzik.org>,
       Alex Tomas <alex@clusterfs.com>, Andrew Morton <akpm@osdl.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       cmm@us.ibm.com, linux-fsdevel@vger.kernel.org,
       Andreas Dilger <adilger@clusterfs.com>
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
Message-ID: <20060609220711.GA29684@ca-server1.us.oracle.com>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Jeff Garzik <jeff@garzik.org>, Alex Tomas <alex@clusterfs.com>,
	Andrew Morton <akpm@osdl.org>,
	ext2-devel <ext2-devel@lists.sourceforge.net>,
	linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
	cmm@us.ibm.com, linux-fsdevel@vger.kernel.org,
	Andreas Dilger <adilger@clusterfs.com>
References: <Pine.LNX.4.64.0606090836160.5498@g5.osdl.org> <m33beecntr.fsf@bzzz.home.net> <Pine.LNX.4.64.0606090913390.5498@g5.osdl.org> <m3k67qb7hr.fsf@bzzz.home.net> <4489A7ED.8070007@garzik.org> <20060609195750.GD10524@thunk.org> <20060609203803.GF3574@ca-server1.us.oracle.com> <20060609210319.GF10524@thunk.org> <20060609212410.GJ3574@ca-server1.us.oracle.com> <20060609215137.GG10524@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060609215137.GG10524@thunk.org>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2006 at 05:51:37PM -0400, Theodore Tso wrote:
> The right approach is what we did with journaling (tune2fs -j or
> tune2fs -O has_journal) and what we did with htree support (tune2fs -O
> dir_index), to explicitly enable that feature, and that's certainly
> what I will be pushing for.

	Excellent.  And now let's close the other side of compatibility.
The attribute problem we discussed with e2fsck has a simple solution:
exit cleanly when you don't understand a filesystem.
	If e2fsck finds an INCOMPAT flag it doesn't understand, it
didn't *fail* to fsck, it just plain doesn't understand the filesystem.
This should not, in any way, prevent bootup from continuing.  Later,
mount may succeed (if the kernel is new enough) or fail (if not), but my
system won't be completely unusable by surprise (assuming that / isn't
the affected filesystem).

Joel

-- 

Bram's Law:
	The easier a piece of software is to write, the worse it's
	implemented in practice.

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
