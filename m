Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289545AbSAJQ7R>; Thu, 10 Jan 2002 11:59:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289546AbSAJQ7I>; Thu, 10 Jan 2002 11:59:08 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:45267 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S289545AbSAJQ6z>; Thu, 10 Jan 2002 11:58:55 -0500
From: Badari Pulavarty <pbadari@us.ibm.com>
Message-Id: <200201101658.g0AGwfo25510@eng2.beaverton.ibm.com>
Subject: Re: [PATCH] PAGE_SIZE IO for RAW (RAW VARY)
To: andrea@suse.de (Andrea Arcangeli)
Date: Thu, 10 Jan 2002 08:58:41 -0800 (PST)
Cc: axboe@suse.de (Jens Axboe), pbadari@us.ibm.com (Badari Pulavarty),
        bcrl@redhat.com (Benjamin LaHaise), linux-kernel@vger.kernel.org,
        marcelo@conectiva.com.br
In-Reply-To: <20020110120926.J3357@inspiron.school.suse.de> from "Andrea Arcangeli" at Jan 10, 2002 11:09:26 AM PST
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea,

> > 
> > I still wouldn't feel to good doing this, and just because snapshotting
> > opens the possibility for this to happen doesn't mean it a) ever
> > triggered in real life, and b) works on all devices.
> 
> fair enough. one way to do it certainly safely is to add a bitflag to
> the struct blkkdev.
> 
> Andrea
> 

Could you please elaborate on your suggestion. What does a biflag in
blkdev do ? 

I am sure by now, you must have understood what my patch is trying to
do. I am trying to issue 4K buffer heads on RAW whenever possible 
(instead of 512). But for the first and last pages buffer heads may
be different size than 4K (due to alignment and length of IO). So, We 
end up with buffer heads with multiple IO sizes in a single request.

How does your suggestion fix the problem ? How can I address this
problem safely. Please let me know.

Thanks,
Badari
