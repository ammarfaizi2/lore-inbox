Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932887AbWF3B7f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932887AbWF3B7f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 21:59:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933140AbWF3B7f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 21:59:35 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:14737 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S932887AbWF3B7e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 21:59:34 -0400
Date: Thu, 29 Jun 2006 18:59:03 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Jeff Garzik <jeff@garzik.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org
Subject: Re: Proposal and plan for ext2/3 future development work
Message-ID: <20060630015903.GE11640@ca-server1.us.oracle.com>
Mail-Followup-To: Jeff Garzik <jeff@garzik.org>,
	Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org
References: <E1Fvjsh-0008Uw-85@candygram.thunk.org> <44A47B0D.7020308@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44A47B0D.7020308@garzik.org>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2006 at 09:14:53PM -0400, Jeff Garzik wrote:
> Agreed overall, though specifically for delayed allocation I think 
> that's an ext4 thing:
> 
> * First off, I'm a big fan of delalloc, and (like extents) definitely 
> want to see the feature implemented
> * Delayed allocation, properly done, requires careful interaction with 
> VM writeback (memory pressure or normal writeout), and may require some 
> minor changes to generic code in fs/* and mm/*

	To be honest, I'd like to see more delayed allocation
infrastructure in the VFS itself.  XFS has to maintain an entire chunk
of state for it, and I suspect ext4 will as well.  I'd love to get
delayed allocation into OCFS2 someday.  Why not move to where we can
share the in-memory accounting code?
	Now, we'd probably want to start by prototyping it in ext4
directly.  Once it's stable as a filesystem feature, we can see where
XFS and ext4 overlap, etc, etc.  But I'd like to keep a more generic
direction in mind.

Joel

-- 

"The suffering man ought really to consume his own smoke; there is no 
 good in emitting smoke till you have made it into fire."
			- thomas carlyle

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
