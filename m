Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261763AbVCVTuW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261763AbVCVTuW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 14:50:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261786AbVCVTuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 14:50:20 -0500
Received: from smtp-roam.Stanford.EDU ([171.64.10.152]:22223 "EHLO
	smtp-roam.Stanford.EDU") by vger.kernel.org with ESMTP
	id S261763AbVCVTrv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 14:47:51 -0500
To: Dave Kleikamp <shaggy@austin.ibm.com>
Cc: JFS Discussion <jfs-discussion@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>, mc@cs.stanford.edu
Subject: Re: [CHECKER] writes not always synchronous on JFS with O_SYNC?
Reply-To: blp@cs.stanford.edu
References: <87vf7kr9gs.fsf@benpfaff.org> <1111498992.8107.5.camel@localhost>
	<1111520471.8082.9.camel@localhost>
From: Ben Pfaff <blp@cs.stanford.edu>
Date: Tue, 22 Mar 2005 11:47:42 -0800
In-Reply-To: <1111520471.8082.9.camel@localhost> (Dave Kleikamp's message of
 "Tue, 22 Mar 2005 13:41:11 -0600")
Message-ID: <87u0n331k1.fsf@benpfaff.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Kleikamp <shaggy@austin.ibm.com> writes:

> This patch to jfs_fsck fixes the problem.  It wasn't really an issue
> with O_SYNC at all, although I believe there are O_SYNC issues that need
> to be resolved.  The data itself should be sync'd correctly, as
> generic_file_write checks for the O_SYNC flag.  The missing piece in jfs
> is that metadata changes to the inode may not always be making it to the
> disk when they should.

Wow, that's an amazingly fast fix.  Thanks!  If I have time
today, I'll re-run the checker after applying your patch.
-- 
Ben Pfaff 
email: blp@cs.stanford.edu
web: http://benpfaff.org
