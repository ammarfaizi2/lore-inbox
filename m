Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130507AbRAaRqT>; Wed, 31 Jan 2001 12:46:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130325AbRAaRqK>; Wed, 31 Jan 2001 12:46:10 -0500
Received: from zurich.ai.mit.edu ([18.43.0.244]:46852 "EHLO zurich.ai.mit.edu")
	by vger.kernel.org with ESMTP id <S130507AbRAaRp4>;
	Wed, 31 Jan 2001 12:45:56 -0500
To: dbr@spoke.nols.com
CC: linux-kernel@vger.kernel.org
Subject: 2.4.1-pre10 -> 2.4.1 klogd at 100% CPU ; 2.4.0 OK
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
User-Agent: IMAIL/1.9; Edwin/3.105; MIT-Scheme/7.5.13
Message-Id: <E14O1K7-0006To-00@aarau.ai.mit.edu>
From: Chris Hanson <cph@zurich.ai.mit.edu>
Date: Wed, 31 Jan 2001 12:45:39 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   I've been trying different 2.4.1-pre kernels trying to find one
   that doesn't end up with klogd pegging the CPU. 2.4.0 is OK, but
   2.4.1-pre10 to 2.4.1 all leave klogd sitting at 100% CPU.

   The machine in question is a Gateway E-3200, a basic PIII-500
   running RH 7.0 with all the latest updates as well as the
   recommended updates documented in the Changes file. The kernel is
   compiled with kgcc (egcs-1.1.2).

I'm seeing exactly the same problem with 2.4.1 on a laptop (HP
OmniBook 6000, 700 MHz PIII) running Debian 2.2, patched to have
modutils 2.4.1 and linux-utils 2.10q.  The kernel was compiled with
gcc 2.95.2.  Again, 2.4.0 worked fine.

BTW, in my case, stopping and restarting klogd makes the problem go
away.  But every time I suspend/resume the machine, it comes back.

On the other hand, a desktop machine (ASUS P2B-LS, 600 MHz PIII)
running Debian woody and Linux 2.4.1 is _not_ having this problem.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
