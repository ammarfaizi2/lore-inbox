Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289099AbSBJAyz>; Sat, 9 Feb 2002 19:54:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289108AbSBJAyp>; Sat, 9 Feb 2002 19:54:45 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17925 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S289099AbSBJAyc>;
	Sat, 9 Feb 2002 19:54:32 -0500
Message-ID: <3C65C4C5.C287A3@mandrakesoft.com>
Date: Sat, 09 Feb 2002 19:54:29 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: ssh primer (was Re: pull vs push (was Re: [bk patch] Make cardbus 
 compile in -pre4))
In-Reply-To: <E16ZhzF-0000ST-00@gondolin.me.apana.org.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu wrote:
> 
> Larry McVoy <lm@bitmover.com> wrote:
> 
> > This is my problem.  You could help if you could tell me what exactly
> > are the magic wands to wave such that you can ssh in without typing
> > a password.  I know about ssh-agent but that doesn't help for this,
> 
> Setup your key with an empty passphrase should do the trick.

Ug.  no.  That is way way insecure.

Most modern distros have an ssh-agent running as a parent of all
X-spawned processed (including processes spawned by xterms).  So, one
only needs to run
	ssh-add ~/.ssh/id_dsa ~/.ssh/identity
once, and input your password once.  After that, no passwords are
needed.


For those with multiple peer shells and no X-parented ssh-agent, you
will need to run ssh-agent ONCE, like so:

	ssh-agent > ~/tmp/ssh-agent.out

and then for each shell, you need to run:

	eval `cat ~/tmp/ssh-agent.out`

and then run the ssh-add command from above.

-- 
Jeff Garzik      | "I went through my candy like hot oatmeal
Building 1024    |  through an internally-buttered weasel."
MandrakeSoft     |             - goats.com
