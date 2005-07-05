Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261884AbVGEPc4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261884AbVGEPc4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 11:32:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261891AbVGEPcz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 11:32:55 -0400
Received: from peabody.ximian.com ([130.57.169.10]:6612 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261884AbVGEPUB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 11:20:01 -0400
Subject: Re: [-mm patch] Fix inotify umount hangs.
From: Robert Love <rml@novell.com>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.60.0507042009170.7572@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0507042009170.7572@hermes-1.csi.cam.ac.uk>
Content-Type: text/plain
Date: Tue, 05 Jul 2005 11:20:04 -0400
Message-Id: <1120576805.6745.197.camel@betsy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-07-04 at 20:28 +0100, Anton Altaparmakov wrote:

> The below patch against 2.6.13-rc1-mm1 fixes the umount hangs caused by 
> inotify.

Thank you, very much, Anton, for hacking on this over the weekend.

It's definitely not the prettiest thing, but there may be no easier
approach.  One thing, the messy code is working around the list
changing, doesn't invalidate_inodes() have the same problem?  If so, it
solves it differently.

I'm also curious if the I_WILL_FREE or i_count check fixed the bug.  I
suspect the other fix did, but we probably still want this.  Or at least
the I_WILL_FREE check.

Anyhow... I'll send out an updated inotify patch after some testing.
Thanks again.

	Robert Love


