Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132539AbRDATQl>; Sun, 1 Apr 2001 15:16:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132540AbRDATQb>; Sun, 1 Apr 2001 15:16:31 -0400
Received: from ns.suse.de ([213.95.15.193]:29712 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S132539AbRDATQS>;
	Sun, 1 Apr 2001 15:16:18 -0400
To: LA Walsh <law@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: unistd.h and 'extern's and 'syscall' "standard(?)"
In-Reply-To: <3AC75DBF.31594195@sgi.com>
X-Yow: I'm having BEAUTIFUL THOUGHTS about the INSIPID WIVES
 of smug and wealthy CORPORATE LAWYERS..
From: Andreas Schwab <schwab@suse.de>
Date: 01 Apr 2001 21:15:35 +0200
In-Reply-To: <3AC75DBF.31594195@sgi.com>
Message-ID: <jelmpktors.fsf@hawking.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.0.101
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

LA Walsh <law@sgi.com> writes:

|>         I have a question.  Some architectures have "system calls"
|> implemented as library calls (calls that are "system calls" on ia32)
|> For example, the expectation on 'arm', seems to be that sys_sync
|> is in a library.  On alpha, sys_open appears to be in a library.
|> Is this correct?
|> 
|>         Is it the expectation that the library that handles this
|> is the 'glibc' for that platform or is there a special "kernel.lib"
|> that goes with each platform?
|> 
|> 	Is there 1 library that I need to link my apps with to
|> get the 'externs' referenced in "unistd.h"?
|> 
|> 	The reason I ask is that in ia64 the 'syscall' call
|> isn't done with inline assembler but is itself an 'extern' call.
|> This implies that you can't do system calls directly w/o some 
|> support library.

Don't use kernel headers in user programs.  Just use syscall(3).

Andreas.

-- 
Andreas Schwab                                  "And now for something
SuSE Labs                                        completely different."
Andreas.Schwab@suse.de
SuSE GmbH, Schanzäckerstr. 10, D-90443 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
