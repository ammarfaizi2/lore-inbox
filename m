Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263233AbTDGDiQ (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 23:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263229AbTDGDiQ (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 23:38:16 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:47074 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261405AbTDGDiP (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 23:38:15 -0400
Date: Mon, 7 Apr 2003 09:21:13 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Janet Morgan <janetmor@us.ibm.com>, akpm@digeo.com, linux-aio@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch 2/2] Retry based aio read - filesystem read changes
Message-ID: <20030407092113.A2137@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <20030305144754.A1600@in.ibm.com> <20030305150026.B1627@in.ibm.com> <20030305024254.7f154afc.akpm@digeo.com> <20030305174452.A1882@in.ibm.com> <3E8889B4.FB716506@us.ibm.com> <20030331191123.GB13178@holomorphy.com> <20030331141629.I20730@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030331141629.I20730@redhat.com>; from bcrl@redhat.com on Mon, Mar 31, 2003 at 02:16:29PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 31, 2003 at 02:16:29PM -0500, Benjamin LaHaise wrote:
> On Mon, Mar 31, 2003 at 11:11:23AM -0800, William Lee Irwin III wrote:
> > Can you tell whether these are due to hash collisions or contention on
> > the same page?
> 
> No, they're most likely waiting for io to complete.
> 
> To clean this up I've got a patch to move from aio_read/write with all the 
> parameters to a single parameter based rw-specific iocb.  That makes the 
> retry for read and write more ameniable to sharing common logic akin to the 
> wtd_ ops, which we need at the very least for the semaphore operations.

Do you also have a patch for handling semaphore operations ?

Regards
Suparna

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Labs, India

