Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288027AbSACAB6>; Wed, 2 Jan 2002 19:01:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288037AbSACABC>; Wed, 2 Jan 2002 19:01:02 -0500
Received: from boden.synopsys.com ([204.176.20.19]:11714 "HELO
	boden.synopsys.com") by vger.kernel.org with SMTP
	id <S287976AbSABX7c>; Wed, 2 Jan 2002 18:59:32 -0500
From: Joe Buck <jbuck@synopsys.COM>
Message-Id: <200201022359.PAA05815@atrus.synopsys.com>
Subject: Re: [PATCH] C undefined behavior fix
To: dewar@gnat.com
Date: Wed, 2 Jan 2002 15:59:25 -0800 (PST)
Cc: paulus@samba.org, velco@fadata.bg, gcc@gcc.gnu.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org,
        trini@kernel.crashing.org
In-Reply-To: <20020102235318.26F2FF2EC7@nile.gnat.com> from "dewar@gnat.com" at Jan 02, 2002 06:53:18 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Dewar writes:

> The concept of "all reasonable compiler implementations" is a very dubious
> one. There is nothing to stop a valid C compiler from building assertions
> based on the quoted paragraph from the C standard, e.g. it could derive
> valid range information from knowing that an offset was constrained to
> certain limits. So writing bogus C like this is risky, and as compilers
> get more sophisticated, one is likely to hear screams, but they are not
> justified in my opinion. There is no excuse for such abuse.

There is already such a project under development: see

http://gcc.gnu.org/projects/bp/main.html

This is a modification to gcc that implements pointers as triples.
While there is a performance penalty for doing this, it can completely
eliminate the problem of exploitable buffer overflows.  However, programs
that violate the rules of ISO C by generating out-of-range pointers will
fail.



