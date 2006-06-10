Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030567AbWFJAp0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030567AbWFJAp0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 20:45:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030565AbWFJAp0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 20:45:26 -0400
Received: from mail.clusterfs.com ([206.168.112.78]:13522 "EHLO
	mail.clusterfs.com") by vger.kernel.org with ESMTP id S1030261AbWFJApZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 20:45:25 -0400
Date: Fri, 9 Jun 2006 18:45:31 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Jeff Garzik <jeff@garzik.org>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Andrew Morton <akpm@osdl.org>,
       "Theodore Ts'o" <tytso@mit.edu>,
       Matthew Frost <artusemrys@sbcglobal.net>,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Mingming Cao <cmm@us.ibm.com>,
       linux-fsdevel@vger.kernel.org, Alex Tomas <alex@clusterfs.com>
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
Message-ID: <20060610004531.GR5964@schatzie.adilger.int>
Mail-Followup-To: Jeff Garzik <jeff@garzik.org>,
	"Stephen C. Tweedie" <sct@redhat.com>, Andrew Morton <akpm@osdl.org>,
	Theodore Ts'o <tytso@mit.edu>,
	Matthew Frost <artusemrys@sbcglobal.net>,
	"ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>, Mingming Cao <cmm@us.ibm.com>,
	linux-fsdevel@vger.kernel.org, Alex Tomas <alex@clusterfs.com>
References: <m3ac8mcnye.fsf@bzzz.home.net> <4489B83E.9090104@sbcglobal.net> <20060609181426.GC5964@schatzie.adilger.int> <4489C34B.1080806@garzik.org> <20060609194959.GC10524@thunk.org> <4489D44A.1080700@garzik.org> <1149886670.5776.111.camel@sisko.sctweedie.blueyonder.co.uk> <4489ECDD.9060307@garzik.org> <1149890138.5776.114.camel@sisko.sctweedie.blueyonder.co.uk> <448A07EC.6000409@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <448A07EC.6000409@garzik.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 09, 2006  19:44 -0400, Jeff Garzik wrote:
> Stephen C. Tweedie wrote:
> > No, we add the same number of inodes in the new groups that all the
> > previous groups have.
> 
> Yes.  Re-read what I wrote.  To put it another way, "mkfs S1 + resize to 
> S2" does not produce precisely the same layout as "mkfs S2".

And in what way is that important?  I mean, really, if this is your argument
that ext3 online resizing is a "hack" then it is pretty weak.  This does
not affect the operation or compatibility of the resized filesystem all the
way back to the stone age (i.e. every single ext2 kernel ever will work
with the resized filesystem).  That is why online resizing (and the resize
inode) are a COMPAT feature.

If I "cp b a /mnt/newfs" and "cp a b /mnt/newfs" "a" and "b" will have
different inode numbers too, but doesn't mean that "cp" is a "hack".

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.

