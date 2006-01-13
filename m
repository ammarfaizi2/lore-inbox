Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161500AbWAMIps@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161500AbWAMIps (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 03:45:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161501AbWAMIps
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 03:45:48 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:53747 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1161500AbWAMIps (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 03:45:48 -0500
Subject: Re: [patch 5/13] s390: show_task oops.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Andrew Morton <akpm@osdl.org>
Cc: heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org
In-Reply-To: <20060112165826.5843e34c.akpm@osdl.org>
References: <20060112171516.GF16629@skybase.boeblingen.de.ibm.com>
	 <20060112165826.5843e34c.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 13 Jan 2006 09:45:42 +0100
Message-Id: <1137141942.6192.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-12 at 16:58 -0800, Andrew Morton wrote:
> Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:
> >
> > From: Heiko Carstens <heiko.carstens@de.ibm.com>
> > 
> > [patch 5/13] s390: show_task oops.
> > 
> > The show_task function walks the kernel stack backchain of
> > processes assuming that the processes are not running. Since
> > this assumption is not correct walking the backchain can lead
> > to an addressing exception and therefore to a kernel hang.
> > So prevent the kernel hang (you still get incorrect results)
> > verity that all read accesses are within the bounds of the
> > kernel stack before performing them.
> > 
> 
> This one needs to be thought about and tested versus the just-merged
> s390-task_stack_page.patch.  I guess it'll still work, but some of the
> pretty new accessors could be used in there, at least.

Oh yes, didn't notice that Al Viro's task_thread_info() changes got
merged in the meantime. We'll test & send a follow-up patch.

-- 
blue skies,
   Martin

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH


