Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261681AbUKIVId@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261681AbUKIVId (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 16:08:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261683AbUKIVId
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 16:08:33 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:32659 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261681AbUKIVIc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 16:08:32 -0500
Date: Tue, 9 Nov 2004 21:08:11 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: Brent Casavant <bcasavan@sgi.com>, Andi Kleen <ak@suse.de>,
       "Adam J. Richter" <adam@yggdrasil.com>, <colpatch@us.ibm.com>,
       <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
Subject: Re: [PATCH] Use MPOL_INTERLEAVE for tmpfs files
In-Reply-To: <463220000.1100030992@flay>
Message-ID: <Pine.LNX.4.44.0411092056090.5291-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Nov 2004, Martin J. Bligh wrote:
>  
> > I'm irritated to realize that we can't change the default for SysV
> > shared memory or /dev/zero this way, because that mount is internal.
> 
> Boggle. shmem I can perfectly understand, and have been intending to
> change for a while. But why /dev/zero ? Presumably you'd always want
> that local?

I was meaning the mmap shared writable of /dev/zero, to get memory
shared between parent and child and descendants, a restricted form
of shared memory.  I was thinking of them running on different cpus,
you're suggesting they'd at least be on the same node.  I dare say,
I don't know.  I'm not desperate to be able to set some other mpol
default for all of them (and each object can be set in the established
way), just would have been happier if the possibility of doing so came
for free with the mount option work.

Hugh

