Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132807AbRDIRk2>; Mon, 9 Apr 2001 13:40:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132809AbRDIRkS>; Mon, 9 Apr 2001 13:40:18 -0400
Received: from isis.its.uow.edu.au ([130.130.68.21]:49315 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S132807AbRDIRkF>; Mon, 9 Apr 2001 13:40:05 -0400
Message-ID: <3AD1F315.2B4ED639@uow.edu.au>
Date: Mon, 09 Apr 2001 10:36:21 -0700
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.18-0.22 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Eloy A. Paris" <eparis@andrew.cmu.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: Processes hanging in D state in 2.4.3 - any findings?
In-Reply-To: <20010409114828.A25594@antenas>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eloy A. Paris" wrote:
> 
> Hi guys,
> 
> I have seen several messages posted to l-k about people reporting
> processes (mozilla most of the time) hanging in the D state in 2.4.3,
> but I haven't seen someone posting a possible explanation or solution
> to the problem.

It's due to problems in the rw_semaphore implementation.  These
were basically unused for a year, then a couple of weeks ago
we started using them, and the problems came to light.

> Anyone knows where does the problem lie, or a workaround for the
> problem? I hate going through the fsck that happens when umount fails
> because processes are in the D state...

I put out a patch yesterday which will fix the problem.  Discussions
are ongoing...

-
