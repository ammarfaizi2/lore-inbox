Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318455AbSHWHXp>; Fri, 23 Aug 2002 03:23:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318546AbSHWHXp>; Fri, 23 Aug 2002 03:23:45 -0400
Received: from smtp.actcom.co.il ([192.114.47.13]:43423 "EHLO
	lmail.actcom.co.il") by vger.kernel.org with ESMTP
	id <S318455AbSHWHXo>; Fri, 23 Aug 2002 03:23:44 -0400
Subject: Re: Hyperthreading
From: Gilad Ben-Yossef <gilad@benyossef.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: James Bourne <jbourne@mtroyal.ab.ca>,
       "Reed, Timothy A" <timothy.a.reed@lmco.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0208211826180.10811-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0208211826180.10811-100000@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 23 Aug 2002 10:28:08 +0300
Message-Id: <1030087689.25063.7.camel@gby.benyossef.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-08-21 at 20:33, Hugh Dickins wrote:
> On Wed, 21 Aug 2002, James Bourne wrote:
> > On Wed, 21 Aug 2002, Reed, Timothy A wrote:
> > > 
> > > Can anyone lead me to a good source of information on what options should be
> > > in the kernel for hyperthreading??  I am still fighting with a
> > > sub-contractor over kernel options.
> > 
> > As long as you have a P4 and use the P4 support you will get
> > hyperthreading with 2.4.19 (CONFIG_MPENTIUM4=y).  2.4.18 you have to also 
> > turn it on with a lilo option of acpismp=force on the kernel command line.
> 
> You do need CONFIG_SMP and a processor capable of HyperThreading,
> i.e. Pentium 4 XEON; but CONFIG_MPENTIUM4 is not necessary for HT,
> just appropriate to that processor in other ways.


hmm... isn't there an option to tell the kernel you are using a
HyperThreaded system, or is it detected on runtime?  I mean, think about
a P4 Xeon 2 way SMP - unless told otherwise the kernel will 'see' it as
a 4 way SMP box *but* the proccessors are not equel!

If for example, you have a task running and another task just woke up
and the scheduler needs to assign a CPU for it, choosing the other
'instance' of the same CPU as the already running task to run it on as
opposed to choosing one of the 'instanaces' of the other seperate CPU
seems a mistake IMHO, but the scheduler won't be able to make the
judgment because it doesn't know it is running on a SMT box at all.

Or am I missing something? :-)

Gilad.

-- 
Gilad Ben-Yossef <gilad@benyossef.com>
http://benyossef.com

"Money talks, bullshit walks and GNU awks."
  -- Shachar "Sun" Shemesh, debt collector for the GNU/Yakuza

