Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261224AbVAGEN5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261224AbVAGEN5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 23:13:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261225AbVAGEN5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 23:13:57 -0500
Received: from web60603.mail.yahoo.com ([216.109.118.223]:62394 "HELO
	web60603.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261224AbVAGENz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 23:13:55 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=cP3SaSvQZW7xrqmmdHWPHuMmEIROxPU1yVMS1lr/ZZJo4tg864mkv6wjKZ1NKOPgjH5kILHZsfNPcq+rd7OblcemzTOr4zBRw6r4vN/zxehtTz2mhb9MKBt5l1aONEJv8PtO8ZtZC+Rx98FiO70UcO7lXu8gcSIbz0EpeF2UQ90=  ;
Message-ID: <20050107041354.45351.qmail@web60603.mail.yahoo.com>
Date: Thu, 6 Jan 2005 20:13:54 -0800 (PST)
From: selvakumar nagendran <kernelselva@yahoo.com>
Subject: Re: finding process blocking on a system call 
To: lkml.ThinkingInBinary@spamgourmet.org
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <e4cb1987050106133642b931ce@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You can't both block but have it added to the
> runqueue--blocking means
> it does not run... you either need to use
> non-blocking calls or two
> threads.  If you want to find the process, top can
> do this
> (interactively) or you can use the /proc filesystem.
> 

Hello,
   I accept that we can't have a process both blocked
and in the runqueue. See, I want to give a special
state to the process blocked on a particular resource
like semaphore as TASK_BLOCKED and I will not add it
into the wait queue. 
   If the scheduler picks up this blocked process
again, I will identify the process that is having the
semaphore and I will run that.  with this, I am giving
some timeslice of the blocked process to the process
having that resource so that it can release it soon.
  So, if a process blocks on the syscall, I will
change the state as TASK_MYSTATE. Since, a process may
block on a system call for many reasons, I am not able
to clearly figure out how can I do that? Can u help me
regarding this?

Thanks,
selva




		
__________________________________ 
Do you Yahoo!? 
Yahoo! Mail - 250MB free storage. Do more. Manage less. 
http://info.mail.yahoo.com/mail_250
