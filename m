Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129346AbRCBR1Z>; Fri, 2 Mar 2001 12:27:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129350AbRCBR1Q>; Fri, 2 Mar 2001 12:27:16 -0500
Received: from fw-1.winstar.com ([207.86.108.130]:63276 "EHLO
	krikey.internal.net") by vger.kernel.org with ESMTP
	id <S129346AbRCBR1E>; Fri, 2 Mar 2001 12:27:04 -0500
Date: Fri, 2 Mar 2001 12:06:46 -0500
From: Ben Collins <bcollins@debian.org>
To: Russell King <rmk@arm.linux.org.uk>
Cc: kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org
Subject: Re: Another rsync over ssh hang (repeatable, with 2.4.1 on both ends)
Message-ID: <20010302120646.C1664@visi.net>
In-Reply-To: <200103021547.SAA16651@ms2.inr.ac.ru> <200103021631.QAA01076@raistlin.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <200103021631.QAA01076@raistlin.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Fri, Mar 02, 2001 at 04:31:07PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 02, 2001 at 04:31:07PM +0000, Russell King wrote:
> kuznet@ms2.inr.ac.ru writes:
> > Russel, you are warned that kernels<2.2.17 and rsync is an incompatible
> > combination.
> 
> So, what you're saying is that because these kernels have known problems
> with rsync, the fact that my symptoms on 2.4.0 are 100% _precisely_ the
> same means its not the same bug?

Well, I can tell you that going from a 2.4.2pre2 sparc64 box via rsync
over ssh to a 2.4.2 or 2.4.1-pre8 i686 gives me the same problems.

However with slight differences. With the 2.4.1-pre8 kernel on the i686
I see "protocol error, different version of rsync?", and with the 2.4.2
kernel I get segv's in the remote rsync (I'm running the rsync -e ssh
from the sparc64).

Both systems are running IDE, ext2 only on both, no special config
options (pretty bare to be honest).

So no, this is not a 2.2.x interaction bug.

-- 
 -----------=======-=-======-=========-----------=====------------=-=------
/  Ben Collins  --  ...on that fantastic voyage...  --  Debian GNU/Linux   \
`  bcollins@debian.org  --  bcollins@openldap.org  --  bcollins@linux.com  '
 `---=========------=======-------------=-=-----=-===-======-------=--=---'
