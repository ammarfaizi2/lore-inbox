Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130343AbQLGCFE>; Wed, 6 Dec 2000 21:05:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129824AbQLGCE5>; Wed, 6 Dec 2000 21:04:57 -0500
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:1799
	"EHLO ani.animx.eu.org") by vger.kernel.org with ESMTP
	id <S130663AbQLGCEe>; Wed, 6 Dec 2000 21:04:34 -0500
Date: Wed, 6 Dec 2000 20:43:58 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: Andrew Morton <andrewm@uow.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: test12-pre6
Message-ID: <20001206204358.B8348@animx.eu.org>
In-Reply-To: <Pine.LNX.4.10.10012052318270.5786-100000@penguin.transmeta.com> <20001206064732.A6542@animx.eu.org> <3A2E2C16.80AF82BB@uow.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <3A2E2C16.80AF82BB@uow.edu.au>; from Andrew Morton on Wed, Dec 06, 2000 at 11:07:50PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Wakko Warner wrote:
> > 
> > >  - pre6:
> > >     - Andrew Morton: exec_usermodehelper fixes
> > 
> > pre4 oopsed all over the place on my alpha with modules and autoloading
> > turned on as soon as it mounted / and freed unused memory.  I take it this
> > was seen on i386 as well?
> 
> No...  The problems showed themselves a little more subtly than that,
> although in the pre5 version there was potential for schedule_task tasks to
> be queued before the kernel thread which handles them was started.
> 
> This shouldn't normally be a problem, but it becomes a fatal problem if
> someone tries to schedule a task and then synchronously waits
> for it to complete, as the new exec_usermodehelper does.
> 
> This change didn't affect module loading per-se.  But the
> kernel does try to run /sbin/hotplug from deep within sys_insert_module
> and sys_delete_module, so they're related.
> 
> > Will try pre6.
> 
> Please.

test12pre6 boots on my alpha and it works with modules enabled (and
autoloading).  Now, if I could only reiserfs worked on alpha!

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
