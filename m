Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129534AbRBYSul>; Sun, 25 Feb 2001 13:50:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129539AbRBYSuc>; Sun, 25 Feb 2001 13:50:32 -0500
Received: from dns-229.dhcp-248.nai.com ([161.69.248.229]:15352 "HELO
	localdomain") by vger.kernel.org with SMTP id <S129534AbRBYSuV>;
	Sun, 25 Feb 2001 13:50:21 -0500
Message-ID: <XFMail.20010225105208.davidel@xmailserver.org>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <3A994FBC.691A143C@sophia.inria.fr>
Date: Sun, 25 Feb 2001 10:52:08 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
To: Fabrice Peix <Fabrice.Peix@sophia.inria.fr>
Subject: RE: sched_yield
Cc: KML <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 25-Feb-2001 Fabrice Peix wrote:
> 
> 
> 
>       Yop,
> 
>       Just a newbie question ...
>       Why sys_sched_yield don't call schedule ?
>       
>       
>       man page of sched_yield tell : 
> 
>       "A  process  can relinquish the processor voluntarily 
>       without blocking by calling sched_yield.  
>       The process will then be moved to the end 
>       of the queue for its static priority and 
>       a new process gets to run."
>       

It sets, under certain conditions ( nr_running ), the variable need_resched
and, in the system call return code this value is checked and schedule() is
called.
Look at sched.c and entry.S.



- Davide

