Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313194AbSEIOkm>; Thu, 9 May 2002 10:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313202AbSEIOk3>; Thu, 9 May 2002 10:40:29 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:20905 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S313194AbSEIOkX>;
	Thu, 9 May 2002 10:40:23 -0400
Importance: Normal
Sensitivity: 
Subject: Re: [Evms-announce] [ANNOUNCE] EVMS Release 1.0.1
To: Andrew Clausen <clausen@gnu.org>
Cc: "Kevin M Corry" <corryk@us.ibm.com>, evms-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.4  June 8, 2000
Message-ID: <OFDE4879C8.491FA45A-ON85256BB4.004CD1A5@pok.ibm.com>
From: "Steve Pratt" <slpratt@us.ibm.com>
Date: Thu, 9 May 2002 09:37:56 -0500
X-MIMETrack: Serialize by Router on D01ML072/01/M/IBM(Release 5.0.10 |March 28, 2002) at
 05/09/2002 10:40:03 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew Clausen:
>It would be nice if the jfs fsim linked against libjfs, rather than
>exec()ing mkfs & friends.

>(mkfs should be a frontend of libjfs)

As Christoph points out in a later note, libjfs really isn't the complete
utilities.

>Notice you have no error handling, etc. now?

Do you mean message handling or error reporting.  Forking JFS mkfs gives me
just as many return codes as libparted (pass/fail) and other than possibly
some messages, this is all EVMS requires.

>Also, the "total system" seems more complicated now.  (For example: how
are you going >to interface the resizer, so you can find out the min/max
sizes, etc?)

I agree that not everything fits well into fork/exec and it was not my
first choice, but it lets the fsim work with existing JFS utilities.  When
JFS implements expand (soon) they will have to deal with this.

>Also, while I'm at it: you didn't like my idea for interfacing
>the parted exception system with evms properly?  I even wrote the code
>for you (without testing it)... I didn't see a reply to my mail...
>you(s) didn't like it?

Not that we didn't like it, just have way to many things to do.

>BTW: what do you think of how libparted interfaces with libreiserfs?
>There has been a lot of work, and it has all been merged properly now.
>I think EVMS should do something similar.  Have a look in
>libparted/fs_reiserfs.

I saw mention that you had done this.  Do you actually allow options to be
passed to the reiserfs utils, or is it still limited to defaults.  Last
time I looked the APIs in libparted didn't provide for this.  Without this
support the whole thing is rather uninteresting to us.

Steve

_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
_______________________________________________
Evms-announce mailing list
Evms-announce@lists.sourceforge.net
To subscribe/unsubscribe, please visit:
https://lists.sourceforge.net/lists/listinfo/evms-announce




