Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317195AbSFKRSD>; Tue, 11 Jun 2002 13:18:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317202AbSFKRSC>; Tue, 11 Jun 2002 13:18:02 -0400
Received: from ns1.ptt.yu ([212.62.32.1]:45190 "EHLO ns1.ptt.yu")
	by vger.kernel.org with ESMTP id <S317195AbSFKRSB>;
	Tue, 11 Jun 2002 13:18:01 -0400
Subject: Re: Process-Shared Mutex (futex) - What is it good for ?
From: Vladimir Zidar <vladimir@mindnever.org>
To: Peter =?ISO-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3D05F8CB.7040409@loewe-komp.de>
Content-Type: text/plain; charset=ISO-8859-1
X-Mailer: Evolution/1.0.2 
Date: 11 Jun 2002 19:18:39 +0200
Message-Id: <1023815929.1388.93.camel@server1>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by ns1.ptt.yu id g5BHHtH22556
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-06-11 at 15:19, Peter Wächtler wrote:

> 
> A-prog:               B-prog:
> 
> gets write lock
> write some data
>                         block on read lock
> write some data
> crashes
>                         wants an error indication to repair data magically

 B-Prog unblocks, but gets -1, with errno=EPIPE.

> 
> 
> So a crashing A-prog is OK for you, but B should get an indication.
> Could catch a signal (SIGLOST?) returning -1 with errno=LOCKBROKEN
> That would be possible with futex.

 Nice if that *would* be possible. But that IS how nutexes are working
already.

> That is a case for writing data to a file - what about linked lists
> in memory?

 Exactly the same. Nutexes are not related to files in any way (other
than /dev/nutex descriptor, but that's completly different thing).


-- 
Bye,

 and have a very nice day !



