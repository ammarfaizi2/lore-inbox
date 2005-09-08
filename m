Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964968AbVIHTw3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964968AbVIHTw3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 15:52:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964970AbVIHTw3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 15:52:29 -0400
Received: from zproxy.gmail.com ([64.233.162.202]:4066 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964968AbVIHTw2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 15:52:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=r6skrHWEv3pqCX6Ym39KERMZD/wuP2zA2DeEcHBFyJfmLcOL5MRGVfAcFuD7cS+HhqsrZJDouO7llya5LjeUiJZfqF4Ae2mCZ3S8syB8UPOkQKOZ3jKA9lFkbkUOPKr7jMSc7JdU/3T+2GcYLxVYVGnd7XJJdsQc1TRR1DDieNg=
Message-ID: <4789af9e05090812521d9d687b@mail.gmail.com>
Date: Thu, 8 Sep 2005 13:52:27 -0600
From: Jim Ramsay <jim.ramsay@gmail.com>
Reply-To: jim.ramsay@gmail.com
To: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
       linux-usb-users@lists.sourceforge.net,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-usb-users] Possible bug in usb storage (2.6.11 kernel)
In-Reply-To: <20050908175852.GA3196@one-eyed-alien.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4789af9e05090810142bd3531d@mail.gmail.com>
	 <20050908175852.GA3196@one-eyed-alien.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/8/05, Matthew Dharm <mdharm-kernel@one-eyed-alien.net> wrote:
> On Thu, Sep 08, 2005 at 11:14:36AM -0600, Jim Ramsay wrote:
> > I think I have found a possible bug:
> > [...]
> > I suppose the scsi code could be changed to guarantee that
> > srb->request_buffer is page-aligned or cache-aligned, but that seems
> > like the wrong solution for this bug.
> 
> Fixing the SCSI layer is -exactly- the correct solution.  The SCSI layer is
> supposed to guarantee us that those buffers are suitable for DMA'ing, and
> apparently it's violating that promise.

Thanks, I'll check on what buffer I'm actually getting, where it's
allocated, and post back what I find, or how I fixed it.

-- 
Jim Ramsay
"Me fail English?  That's unpossible!"
