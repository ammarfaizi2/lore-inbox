Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287699AbSAFEOx>; Sat, 5 Jan 2002 23:14:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287697AbSAFEOo>; Sat, 5 Jan 2002 23:14:44 -0500
Received: from samba.sourceforge.net ([198.186.203.85]:46091 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S287703AbSAFEOd>;
	Sat, 5 Jan 2002 23:14:33 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15415.51007.526663.158008@argo.ozlabs.ibm.com>
Date: Sun, 6 Jan 2002 14:40:47 +1100 (EST)
To: dewar@gnat.com
Cc: gcc@gcc.gnu.org, linux-kernel@vger.kernel.org, trini@kernel.crashing.org,
        velco@fadata.bg
Subject: Re: [PATCH] C undefined behavior fix
In-Reply-To: <20020104224325.04B43F319D@nile.gnat.com>
In-Reply-To: <20020104224325.04B43F319D@nile.gnat.com>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dewar@gnat.com writes:

> <<Sorry, you are correct.  I should have written "One of the reasons why
> C used to be a good language for writing operating system kernels ..."
> >>
> 
> C is perfectly well suited for writing operating system kernels, but you

Actually, having seen some of the subsequent messages in this thread,
for example this gem from Florian Weimer, I stand by my statement. :)

> You cannot manipulate machine addresses in C because C is
> defined as a high-level language, without backdoors to such low-level
> concepts as machine addresses.

We keep getting told that there is nothing in the standard that says
that the compiler has to give us a way to construct a pointer (one
that we can dereference) from an address, and that if we think we have
a way at the moment we shouldn't rely on it because it might change at
any minute, and if it does and our kernel doesn't work any more it's
all our fault.

> absolutely HAVE to know what you are doing, and that includes knowing the
> C standard accurately, and clearly identifying any implementation dependent
> behavior that you are counting on.

There are some C compilers that are useful for implementing a kernel,
that's true.  But when the maintainers of such a compiler say things
that imply that they feel they are constrained only by the standard
and not by the needs of their users, it is very discouraging.

> The "used to be" is bogus. The (base + offset) memory model of C has been
> there since the earliest days of the definition of C. The only thing that
> "used to be" the case is that people ignored these rules freely and since
> compilers were fairly stupid, they got away with this rash behavior.

Oh, I was talking about the original C language as it was designed and
implemented by 2 or 3 smart people who were also using it to build a
kernel, a compiler and a lot of other programs.  Not that the original
C language didn't have flaws; it did, and the ANSI committee that
developed the standard fixed a lot of them.  But I do feel that the
language has drifted away from its roots as a systems programming
language.

Paul.
