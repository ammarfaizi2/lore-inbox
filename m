Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267165AbUJBBqv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267165AbUJBBqv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 21:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267170AbUJBBqv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 21:46:51 -0400
Received: from fw.osdl.org ([65.172.181.6]:50358 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267165AbUJBBqt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 21:46:49 -0400
Date: Fri, 1 Oct 2004 18:44:31 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jean Delvare <khali@linux-fr.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: mmap() on cdrom files fails since 2.6.9-rc2-bk2 (Was: in -mmX)
Message-Id: <20041001184431.4e0c6ba5.akpm@osdl.org>
In-Reply-To: <20040929222619.5da3f207.khali@linux-fr.org>
References: <2Jw9b-52b-13@gated-at.bofh.it>
	<20040929222619.5da3f207.khali@linux-fr.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Delvare <khali@linux-fr.org> wrote:
>
> Quoting myself:
> 
> > I think I found a bug in 2.6.9-rc2-mm4. It doesn't seem to be able to
> > mmap() files located on cdroms. Same problem with -mm3 and -mm1.
> > 2.6.9-rc2 works fine. I reproduced it on two completely different
> > systems, so I guess it isn't device dependant.
> 
> Looks like I should have done more testing before reporting. The problem
> is not only in -mmX, it shows in the -bk series as well. The mmap()
> problem I am experiencing seems to have been introduced between
> 2.6.9-rc2-bk1 and 2.6.9-rc2-bk2. This somewhat narrows the research
> field.

It works OK here.  Can you put together a simple test app?

Is it an iso9660 filesystem?

> I still don't know how to investigate the problem any further.
> Suggestions welcome.

Try the same thing on a read-only mounted ext3 filesystem, maybe?

Capture the strace output.
