Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265970AbSKBNc7>; Sat, 2 Nov 2002 08:32:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265971AbSKBNcw>; Sat, 2 Nov 2002 08:32:52 -0500
Received: from mailout04.sul.t-online.com ([194.25.134.18]:54438 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S265970AbSKBNct>; Sat, 2 Nov 2002 08:32:49 -0500
Cc: Dax Kelson <dax@gurulabs.com>, Rusty Russell <rusty@rustcorp.com.au>,
       linux-kernel@vger.kernel.org, torvalds@transmeta.com, davej@suse.de
References: <20021101085148.E105A2C06A@lists.samba.org>
	<1036175565.2260.20.camel@mentor>
	<20021102070607.GB16100@think.thunk.org>
From: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
To: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: Filesystem Capabilities in 2.6?
Date: Sat, 02 Nov 2002 14:38:56 +0100
Message-ID: <87znssytu7.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Honest Recruiter,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Theodore Ts'o" <tytso@mit.edu> writes:

> Ugh.  Personally, as I've said, I'm not convinced filesystem
> capabilities is worth it, providing the illusion of security --- and

Like ACL? SCNR :-)

> probably will make most systems more insecure because most system
> administrators won't be able to deal with fs capabilties competently.

I still don't get it. How is this different from suid root. The worst
I can imagine is an admin doing chcap all+eip, which is no different
from doing a chown root; chmod u+s.

> HOWEVER, if we're going to do it, Olaf's patches is really not the way
> to do it.  If we're going to do it at all, the right way to do it is
> via extended attributes.  Using a sparse file to store capabilities
> indexed by inode numbers is a bad idea; it will break if the user uses
> resize2fs on an ext2/3 filesystem, for example.

Dragging yet another one out of you. This is a pretty strong argument
against my implementation. Any other hints?

Regards, Olaf.
