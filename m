Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S153981AbPGTLYi>; Tue, 20 Jul 1999 07:24:38 -0400
Received: by vger.rutgers.edu id <S153929AbPGTLYT>; Tue, 20 Jul 1999 07:24:19 -0400
Received: from pa239.warszawa.ppp.tpnet.pl ([212.160.52.239]:49199 "HELO olaf") by vger.rutgers.edu with SMTP id <S153856AbPGTLXt>; Tue, 20 Jul 1999 07:23:49 -0400
Message-ID: <37945BBB.711FAFA5@geocities.com>
Date: Tue, 20 Jul 1999 13:21:31 +0200
From: Artur Skawina <skawina@geocities.com>
X-Mailer: Mozilla 3.04 (X11; U; Linux 2.3.5as i686)
MIME-Version: 1.0
To: Kurt Garloff <garloff@suse.de>
CC: linux-kernel@vger.rutgers.edu, Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
Subject: Re: [RFC] increasing and masquerading HZ
References: <3793EDBB.6B7D7E12@geocities.com> <19990720105551.C9486@bari.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-kernel@vger.rutgers.edu

Kurt Garloff wrote:
> 

> Without looking into details, I saw a place, where I did HZ conversion where

i did that conversion after doing the math, to avoid doing it twice, iirc.


> You may want to merge your patch with one from
>  Harald Koerfgen <Harald.Koerfgen@home.ivm.de>
> on
>  ftp://ftp.linux.sgi.com/pub/linux/mips/test/hz_patch.gz
> 
> He mailed me about necessary changes for his MIPS work. I did not yet find
> time to answer him, but maybe you can contact him and get the changes merged.

except the mips-only change, the only thing missing is one #include "param.h".
 

> Basically, independance of userspace from the internal HZ is good. This is

yes, it's a requirement. There are still a few issues left:

o stability - the machine i tried this on locked up hard while running
  a kernel with this patch. It's otherwise rock solid... Hmm, was there
  a known (scheduling) bug in 2.3.5 that could get triggered by a big HZ?
  Will try to reproduce...
o the ip routing sysctls (i'd rather not touch these)
o /proc/net/tcp and friends (look at the "netstat -to" output...),
   this one will be easy to fix.

artur


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
