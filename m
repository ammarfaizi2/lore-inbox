Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261568AbTH2RbF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 13:31:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261572AbTH2RbF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 13:31:05 -0400
Received: from relay2.EECS.Berkeley.EDU ([169.229.60.28]:14530 "EHLO
	relay2.EECS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S261568AbTH2Ra7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 13:30:59 -0400
Subject: Re: [PATCH 2.4] i2c-dev user/kernel bug and mem leak
From: "Robert T. Johnson" <rtjohnso@eecs.berkeley.edu>
To: Jean Delvare <khali@linux-fr.org>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org, marcelo@conectiva.com.br,
       sensors@Stimpy.netroedge.com, vsu@altlinux.ru
In-Reply-To: <20030829182132.29c3ac55.khali@linux-fr.org>
References: <20030803192312.68762d3c.khali@linux-fr.org>
	<20030804193212.11786d06.vsu@altlinux.ru>
	<20030805103240.02221bed.khali@linux-fr.org>
	<20030805210704.GA5452@kroah.com>
	<20030806100702.78298ffe.khali@linux-fr.org>
	<1060886657.1006.7121.camel@dooby.cs.berkeley.edu>
	<20030814190954.GA2492@kroah.com>
	<1060912895.1006.7160.camel@dooby.cs.berkeley.edu>
	<20030815211329.GB4920@kroah.com>
	<1062033440.16799.22.camel@dooby.cs.berkeley.edu> 
	<20030829182132.29c3ac55.khali@linux-fr.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 29 Aug 2003 10:30:50 -0700
Message-Id: <1062178250.2321.20.camel@dooby.cs.berkeley.edu>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-08-29 at 09:21, Jean Delvare wrote:
> > Here's the patch against 2.6.0-test4.  Just to remind everyone, this
> > patch doesn't fix any bugs (they're already fixed in 2.6.0-test3), it
> > just makes the code pass our static analysis tool, cqual, without
> > generating a warning.  Since finding and fixing these bugs is so
> > tricky, it seems worthwhile to have code which can be automatically
> > verified to be bug-free (at least w.r.t. user/kernel pointers). 
> > That's what this patch is about.  Let me know if you have any
> > questions or comments. Thanks for everyone's help.
> 
> If I read the patch correctly, this is basically a kind of reversal to
> your original patch, before Sergey and I changed it?

You're absolutely right.  The patch is purely "aesthetic", in the sense
that it gets the code to pass cqual without generating any warnings.  I
understand the code may seem slightly odd, but it can be _automatically_
verified to have no user/kernel bugs.  That's its real advantage.

Thanks for looking at the patch so carefully, and for your comments.

Best,
Rob


