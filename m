Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262420AbTCBUdb>; Sun, 2 Mar 2003 15:33:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262789AbTCBUdb>; Sun, 2 Mar 2003 15:33:31 -0500
Received: from packet.digeo.com ([12.110.80.53]:22743 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262420AbTCBUda>;
	Sun, 2 Mar 2003 15:33:30 -0500
Date: Sun, 2 Mar 2003 12:43:58 -0800
From: Andrew Morton <akpm@digeo.com>
To: "Felipe Alfaro Solana" <felipe_alfaro@linuxmail.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: anticipatory scheduling questions
Message-Id: <20030302124358.5e4c4751.akpm@digeo.com>
In-Reply-To: <20030302114035.22346.qmail@linuxmail.org>
References: <20030302114035.22346.qmail@linuxmail.org>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Mar 2003 20:43:48.0196 (UTC) FILETIME=[6CD34240:01C2E0FC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Felipe Alfaro Solana" <felipe_alfaro@linuxmail.org> wrote:
>
> > You have not actually said whether 2.5.63 base exhibits 
> > the same problem.  From the vmstat traces it appears 
> > that the answer is "yes"? 
>  
> Both 2.5.63 and 2.5.63-mm1 exhibit this behavior, but 
> can't be reproduced with 2.4.20-2.54. 

By 2.54 I assume you mean 2.5.54?

> > > I have retested this with 2.4.20-2.54, 2.5.63 and 2.5.63-mm1...  
> > > and have attached the files to this message 
> >  
> > Thanks.  Note how 2.4 is consuming a few percent CPU, whereas 2.5 is 
> > consuming 100%.  Approximately half of it system time. 
>  
> It seems is not "user" or "system" time what's being consumed, it's 
> "iowait" Look below :-) 

Your vmstat traces were showing tons of user time as well as system
time.  Please make sure that you have the latest version of procps,
from http://surriel.com/procps/ or http://procps.sourceforge.net/

> > It does appear that some change in 2.5 has caused evolution to go berserk 
> > during this operation. 
>  
> I wouldn't say it's exactly Evolution what's going berserk. Doing a 
> "top -s1" while trying to reply to a big e-mail message, I've noticed 
> that "top" reports "iowait" starting at ~50%, then going up very fast 
> and then staying up at 90-95% all the time. This happens on 2.5.63 
> and 2.5.63-mm1, however, on 2.4.20-2.54 kernel, "iowait" stays all 
> the time exactly at "0%" and idle time remains steady at 90-95%. 

Well certainly the IO stream _looks_ like it is stuck in IO-wait a lot.

It is strange that this has been happening for a couple of months and seems
to only affect Felipe Solana's copy of evolution.  I still can't get my copy
to spellcheck a thing.  I need to wrestle with it a bit more.


