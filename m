Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S155299AbPFBVQl>; Wed, 2 Jun 1999 17:16:41 -0400
Received: by vger.rutgers.edu id <S154464AbPFBU0M>; Wed, 2 Jun 1999 16:26:12 -0400
Received: from mentolat-e0.core.genedata.com ([157.161.173.16]:31684 "EHLO mail.core.genedata.com") by vger.rutgers.edu with ESMTP id <S154679AbPFBSMX>; Wed, 2 Jun 1999 14:12:23 -0400
Date: Wed, 2 Jun 1999 20:12:05 +0200
From: Matthew Wilcox <Matthew.Wilcox@genedata.com>
To: Philip Blundell <pb@nexus.co.uk>
Cc: Jordan Mendelson <jordy@wserv.com>, linux-kernel@vger.rutgers.edu
Subject: Re: XTP: A better TCP than TCP
Message-ID: <19990602201205.S1415@mencheca.ch.genedata.com>
References: <37544C46.C9A1AA12@wserv.com> <E10p6Y7-00008z-00@fountain.nexus.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <E10p6Y7-00008z-00@fountain.nexus.co.uk>; from Philip Blundell on Wed, Jun 02, 1999 at 09:38:59AM +0100
Sender: owner-linux-kernel@vger.rutgers.edu

On Wed, Jun 02, 1999 at 09:38:59AM +0100, Philip Blundell wrote:
> >I was just reviewing http://www.mentat.com/xtp/xtp.html and
> >http://www.ca.sandia.gov/xtp/. XTP looks like a very interesting protocol. 
> 
> I did some work with XTP a few years back.  It's interesting but it's a very 
> heavyweight protocol compared to TCP.  It tries to be all things to all men 
> and it's debatable whether it really succeeds.
> 
> It would certainly be worth having in the kernel, however.

I think a much more interesting protocol to have in the kernel would
be Bell Labs' IL.  It's implemented in Plan 9, and they say they are
very happy with its performance.  It's a sequenced packet protocol,
ideal for NFS, CORBA messages and pretty much anything which currently
either implements its own out-of-order + retransmit strategy over UDP
or puts packet boundaries into TCP.

There's a description of the protocol at
http://plan9.bell-labs.com/plan9/doc/il.html
I have the barest bones of a start at a linux implementation of it,
if anyone wants to collaborate :-)

-- 
Matthew Wilcox <willy@bofh.ai>
"Windows and MacOS are products, contrived by engineers in the service of
specific companies. Unix, by contrast, is not so much a product as it is a
painstakingly compiled oral history of the hacker subculture." - N Stephenson

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
