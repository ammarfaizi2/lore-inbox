Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261840AbTCaTGm>; Mon, 31 Mar 2003 14:06:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261841AbTCaTGm>; Mon, 31 Mar 2003 14:06:42 -0500
Received: from holomorphy.com ([66.224.33.161]:42948 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261840AbTCaTGk>;
	Mon, 31 Mar 2003 14:06:40 -0500
Date: Mon, 31 Mar 2003 11:17:35 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Janet Morgan <janetmor@us.ibm.com>, akpm@digeo.com, suparna@in.ibm.com,
       linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch 2/2] Retry based aio read - filesystem read changes
Message-ID: <20030331191735.GC13178@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Benjamin LaHaise <bcrl@redhat.com>,
	Janet Morgan <janetmor@us.ibm.com>, akpm@digeo.com,
	suparna@in.ibm.com, linux-aio@kvack.org,
	linux-kernel@vger.kernel.org
References: <20030305144754.A1600@in.ibm.com> <20030305150026.B1627@in.ibm.com> <20030305024254.7f154afc.akpm@digeo.com> <20030305174452.A1882@in.ibm.com> <3E8889B4.FB716506@us.ibm.com> <20030331191123.GB13178@holomorphy.com> <20030331141629.I20730@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030331141629.I20730@redhat.com>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 31, 2003 at 11:11:23AM -0800, William Lee Irwin III wrote:
>> Can you tell whether these are due to hash collisions or contention on
>> the same page?

On Mon, Mar 31, 2003 at 02:16:29PM -0500, Benjamin LaHaise wrote:
> No, they're most likely waiting for io to complete.
> To clean this up I've got a patch to move from aio_read/write with all the 
> parameters to a single parameter based rw-specific iocb.  That makes the 
> retry for read and write more ameniable to sharing common logic akin to the 
> wtd_ ops, which we need at the very least for the semaphore operations.

I won't get in the way then. I just watch for things related to what I've
touched to make sure it isn't going wrong for anyone.


-- wli
