Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <160454-2781>; Fri, 8 Jan 1999 14:25:56 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:3653 "EHLO saturn.cs.uml.edu" ident: "NO-IDENT-SERVICE[2]") by vger.rutgers.edu with ESMTP id <160808-2781>; Fri, 8 Jan 1999 02:44:08 -0500
Date: Fri, 8 Jan 1999 05:12:31 -0500 (EST)
Message-Id: <199901081012.FAA22697@saturn.cs.uml.edu>
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
To: linux-kernel@vger.rutgers.edu
Subject: Re: Porting vfork()
Sender: owner-linux-kernel@vger.rutgers.edu


Chris Wedgwood writes:
> On Wed, Jan 06, 1999 at 08:28:55PM -0600, kernel@draper.net wrote:

>> 2) When the parent can no longer assume (and requires) that the
>>    child will be dispatched and execve prior to the parent
>>    receiving control back from vfork()...  a subtle race condition
>>    porting problem arises.
>
> I can't think of an easy way to make this work...

Linus posted a basic roadmap. Without this, the shared VM is insane.

>> My intent in this thread was to gage the vfork() impact.
> 
> We've go this far without it -- and it is a bit of a hack. I don't
> see why we should need to add it now. We should be able to fix a
> small handful of applications, and almost any OS can use fork()
> without too much penality as most implement COW.

NetBSD has a "Why implement traditional vfork()" page that explains
why they reimplemented vfork(). It seems vfork() is still good.

http://www.netbsd.org/Documentation/kernel/vfork.html

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
