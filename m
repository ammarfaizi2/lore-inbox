Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132193AbQLHODJ>; Fri, 8 Dec 2000 09:03:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132158AbQLHODA>; Fri, 8 Dec 2000 09:03:00 -0500
Received: from e56090.upc-e.chello.nl ([213.93.56.90]:18694 "EHLO unternet.org")
	by vger.kernel.org with ESMTP id <S132147AbQLHOCp>;
	Fri, 8 Dec 2000 09:02:45 -0500
Date: Fri, 8 Dec 2000 14:32:08 +0100
From: Frank de Lange <frank@unternet.org>
To: Juergen Kreileder <jk@blackdown.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: java (and possibly other threaded apps) hanging in rt_sigsuspend
Message-ID: <20001208143208.B960@unternet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Can you reproduce this without strace?
> 
> I only see this problem when I run with 'strace -f' and java wants to
> exit (apart from that java works correctly). I don't see the dependency
> on the heap size here.

Yes, I only started using strace when the problem became apperent. Java 1.3.0
does NOT start with any maximum heap size value lower than 49 Mb (java -Xmx48mb
will stall, java -Xmx49m will start). The javaplugin for mozilla also fails to start in a similar fashion.

(cc'd to the l-k list)

Cheers//Frank
-- 
  WWWWW      _______________________
 ## o o\    /     Frank de Lange     \
 }#   \|   /                          \
  ##---# _/     <Hacker for Hire>      \
   ####   \      +31-320-252965        /
           \    frank@unternet.org    /
            -------------------------
 [ Hacker: http://www.jargon.org/html/entry/hacker.html ]
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
