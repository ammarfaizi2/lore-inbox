Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285389AbRLGDiQ>; Thu, 6 Dec 2001 22:38:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285397AbRLGDiH>; Thu, 6 Dec 2001 22:38:07 -0500
Received: from [198.99.130.100] ([198.99.130.100]:58497 "EHLO karaya.com")
	by vger.kernel.org with ESMTP id <S285389AbRLGDhy>;
	Thu, 6 Dec 2001 22:37:54 -0500
Message-Id: <200112070440.fB74e9G05294@karaya.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: Adam Keys <akeys@post.cis.smu.edu>
cc: Larry McVoy <lm@bitmover.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SMP/cc Cluster description 
In-Reply-To: Your message of "Thu, 06 Dec 2001 20:49:58 CST."
             <20011207024919.MBX24045.rwcrmhc53.attbi.com@there> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 06 Dec 2001 23:40:09 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

akeys@post.cis.smu.edu said:
>  it seemed to me that you could easily  simulate what you want with
> lots of UML's talking to each other. I think you  would need to create
> some kind of device that uses a file or a shared memory  segment as
> the cluster's memory. 

Yeah, there is already support for mapping in a random file and using that
as UML memory, so that would be used for the cluster interconnect for any
cluster emulations you wanted to run with UML.

> Actually, I think that (shared memory) is  how
> Jeff had intended on implementing SMP in UML anyway.

No, at least not any shared memory that's not already there.  UML uses a 
host process for each UML process, and UML kernel data and text are
shared between all these host processes.  SMP just means having more than
one host process runnable at a time.  Each runnable process on the host
is a virtual processor.

> At this point I
> don't think UML supports SMP though I know of at least one person who
> was  attempting it.

It doesn't yet.  Someone is (or was), but I haven't heard a peep from him in
at least a month.  So this is starting to look like another little project
which got quickly going but just as quickly abandoned.

				Jeff

