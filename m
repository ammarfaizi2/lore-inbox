Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318221AbSGWVlR>; Tue, 23 Jul 2002 17:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318222AbSGWVlR>; Tue, 23 Jul 2002 17:41:17 -0400
Received: from jalon.able.es ([212.97.163.2]:37802 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S318221AbSGWVlP>;
	Tue, 23 Jul 2002 17:41:15 -0400
Date: Tue, 23 Jul 2002 23:44:10 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: John Covici <covici@ccs.covici.com>, linux-kernel@vger.kernel.org
Subject: Re: is flock broken in 2.4 or 2.5 kernels or what does this mean?
Message-ID: <20020723214410.GA3249@werewolf.able.es>
References: <m37kjmik0g.fsf@ccs.covici.com> <1027441872.31787.139.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1027441872.31787.139.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Tue, Jul 23, 2002 at 18:31:12 +0200
X-Mailer: Balsa 1.3.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.07.23 Alan Cox wrote:
>On Tue, 2002-07-23 at 15:41, John Covici wrote:
>> In the latest release notes of sendmail I have read the following:
>> 
>> 		NOTE: Linux appears to have broken flock() again.  Unless
>> 			the bug is fixed before sendmail 8.13 is shipped,
>> 			8.13 will change the default locking method to
>> 			fcntl() for Linux kernel 2.4 and later.  You may
>> 			want to do this in 8.12 by compiling with
>> 			-DHASFLOCK=0.  Be sure to update other sendmail
>> 			related programs to match locking techniques.
>> 
>> Can anyone tell me what this is all about -- is there any basis in
>> reality for what they are saying?
>
>First I've heard of it, so it would be useful if someone has access to
>the sendmail problem report/test in question that shows it and I'll go
>find out.
>

Perhaps if you have your spool over nfs:

man flock:

NOTES
       flock(2) does not  lock  files  over  NFS.   Use  fcntl(2)
       instead:  that  does  work  over NFS, given a sufficiently
       recent version of Linux and a server which supports  lock­
       ing.

       flock(2)  and fcntl(2) locks have different semantics with
       respect to forked processes and dup(2).

-- 
J.A. Magallon             \   Software is like sex: It's better when it's free
mailto:jamagallon@able.es  \                    -- Linus Torvalds, FSF T-shirt
Linux werewolf 2.4.19-rc3-jam1, Mandrake Linux 9.0 (Cooker) for i586
gcc (GCC) 3.1.1 (Mandrake Linux 8.3 3.1.1-0.10mdk)
