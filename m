Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289622AbSAJTZ3>; Thu, 10 Jan 2002 14:25:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289621AbSAJTZV>; Thu, 10 Jan 2002 14:25:21 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:43198 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S289622AbSAJTZG>; Thu, 10 Jan 2002 14:25:06 -0500
From: Badari Pulavarty <pbadari@us.ibm.com>
Message-Id: <200201101924.g0AJO6s02748@eng2.beaverton.ibm.com>
Subject: Re: [PATCH] PAGE_SIZE IO for RAW (RAW VARY)
To: andrea@suse.de (Andrea Arcangeli)
Date: Thu, 10 Jan 2002 11:24:06 -0800 (PST)
Cc: axboe@suse.de (Jens Axboe), pbadari@us.ibm.com (Badari Pulavarty),
        bcrl@redhat.com (Benjamin LaHaise), linux-kernel@vger.kernel.org,
        marcelo@conectiva.com.br, axboe@brick.kernel.dk
In-Reply-To: <20020110120926.J3357@inspiron.school.suse.de> from "Andrea Arcangeli" at Jan 10, 2002 11:09:26 AM PST
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> fair enough. one way to do it certainly safely is to add a bitflag to
> the struct blkkdev.
> 
> Andrea
> 

Thanks to Andrea !! 

How about adding a flag in blk_dev structure. (I currently couldn't find one).
Set the flag for the drivers which support multiple bufferhead sizes in
a single IO request and use this flag to do RAW VARY or not.

Does this address everyones concerns ? I am willing to work with the
drivers I tested/reviewed/verified to make the change to set the flag.
As driver owners verify their drivers, could set the flag (in future).

If everyone is okay with this approach, I can make a new patch for this.

Thanks,
Badari

