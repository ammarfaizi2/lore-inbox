Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311482AbSCSReb>; Tue, 19 Mar 2002 12:34:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311487AbSCSReV>; Tue, 19 Mar 2002 12:34:21 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:33532 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S311482AbSCSReP>;
	Tue, 19 Mar 2002 12:34:15 -0500
Message-ID: <3C977675.AEB0C62B@mvista.com>
Date: Tue, 19 Mar 2002 09:33:41 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Joy Mukherjee <jmukherj@vt.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: pthread_sighandler
In-Reply-To: <3CA40295@zathras>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joy Mukherjee wrote:
> 
> hi !
>  I apologize for this this probably inappropriate question but i am writing as
> a last option - how can I know at which instruction (the IP) a thread was
> interrupted by SIGALRM ? Thank you very much and sorry once again .
> 
I am not going to do all your research for you, but you just need to set
up a signal handler for SIGALARM with the capability of recovering the
process state.  I think this is the third parameter in the handler
call.  You will need to look at the signal man pages to find out how to
do this and, most likely you will need to find the header file that
describes the state structure to figure out what member has what you
want.
-- 
George           george@mvista.com
High-res-timers: http://sourceforge.net/projects/high-res-timers/
Real time sched: http://sourceforge.net/projects/rtsched/
