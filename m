Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289139AbSBJBXC>; Sat, 9 Feb 2002 20:23:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289140AbSBJBWm>; Sat, 9 Feb 2002 20:22:42 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:7952 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S289139AbSBJBWi>;
	Sat, 9 Feb 2002 20:22:38 -0500
Message-ID: <3C65CB5B.126C3AD5@mandrakesoft.com>
Date: Sat, 09 Feb 2002 20:22:35 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Lang <david.lang@digitalinsight.com>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Larry McVoy <lm@bitmover.com>,
        linux-kernel@vger.kernel.org
Subject: Re: ssh primer (was Re: pull vs push (was Re: [bk patch] Make 
 cardbuscompile in -pre4))
In-Reply-To: <Pine.LNX.4.44.0202091713180.25220-100000@dlang.diginsite.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Lang wrote:
> how does this work when running something from cron? (I think that's the
> type of thing Larry is trying to do)

A simple mutation of this:


> > For those with multiple peer shells and no X-parented ssh-agent, you
> > will need to run ssh-agent ONCE, like so:
> >
> >       ssh-agent > ~/tmp/ssh-agent.out
> >
> > and then for each shell, you need to run:
> >
> >       eval `cat ~/tmp/ssh-agent.out`


Run ssh-agent and ssh-add once per reboot, such as from
/usr/local/bin/login-bkpull.

>From the cron script, run the eval line shown.

No passwords are prompted for.

	Jeff



-- 
Jeff Garzik      | "I went through my candy like hot oatmeal
Building 1024    |  through an internally-buttered weasel."
MandrakeSoft     |             - goats.com
