Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132457AbQL1Mkd>; Thu, 28 Dec 2000 07:40:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130003AbQL1MkO>; Thu, 28 Dec 2000 07:40:14 -0500
Received: from delta.ds2.pg.gda.pl ([153.19.144.1]:37616 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S129835AbQL1MkL>; Thu, 28 Dec 2000 07:40:11 -0500
Date: Thu, 28 Dec 2000 13:06:59 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@uni-koblenz.de>
cc: Joe deBlaquiere <jadb@redhat.com>, the list <linux-kernel@vger.kernel.org>,
        linux-mips@oss.sgi.com, linux-mips@fnet.fr
Subject: Re: sysmips call and glibc atomic set
In-Reply-To: <20001226140204.D894@bacchus.dhis.org>
Message-ID: <Pine.GSO.3.96.1001228123903.21148B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Dec 2000, Ralf Baechle wrote:

> The semantics of this syscall were previously defined by Risc/OS and later
> on continued to be used by IRIX.

 Ralf, could you please provide me a copy of a man page for the call?  I
don't have access to either of the systems and a search of the Net
returned nothing. 

> Don't think about SMP without ll/sc.  There's algorithems available for
> that but their complexity leaves them a unpractical, theoretical construct.

 For SMP there is a simple kernel solution available.  It suitable for a
syscall or a ll/sc emulation.  There is no easy userland-only solution
AFAIK.

> Above code will break if the old content of memory has bit 31 set or you take
> pagefaults.  The latter problem is a problem even on UP - think multi-
> threading.

 If the code is written carefully you don't ever get a pagefault that
would break consistency.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
