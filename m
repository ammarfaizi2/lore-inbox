Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133023AbQLNVUs>; Thu, 14 Dec 2000 16:20:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135186AbQLNVU3>; Thu, 14 Dec 2000 16:20:29 -0500
Received: from gherkin.sa.wlk.com ([192.158.254.49]:57348 "HELO
	gherkin.sa.wlk.com") by vger.kernel.org with SMTP
	id <S133023AbQLNVUV>; Thu, 14 Dec 2000 16:20:21 -0500
Message-Id: <m146fJj-0005keC@gherkin.sa.wlk.com>
From: rct@gherkin.sa.wlk.com (Bob_Tracy)
Subject: Re: ip_defrag is broken (was: Re: test12 lockups -- need feedback)
In-Reply-To: <200012141838.eBEIc1v08746@moisil.dev.hydraweb.com>
 "from Ion Badulescu at Dec 14, 2000 10:38:01 am"
To: Ion Badulescu <ionut@moisil.cs.columbia.edu>
Date: Thu, 14 Dec 2000 14:49:31 -0600 (CST)
CC: linux-kernel@vger.kernel.org, davem@redhat.com, mhaque@haque.net
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ion Badulescu wrote:
> On Thu, 14 Dec 2000 07:15:04 -0500, Mohammad A. Haque <mhaque@haque.net> wrote:
> > Were you connected to a network or receiving/sending anything?
> 
> ip_defrag is broken -- there is an obvious NULL pointer dereference
> in it, introduced in test12. It doesn't hit normally, because of
> path MTU discovery, but using NFS causes instant death.

This is consistent with the lockup I reported several hours ago.
In the case of my "unstable" 2.4.0-test12 machine where "startx"
worked fine for "root" but not for a normal user, the "root"
account is local.  The normal user account home directories are
NFS mounted :-(.

Good spot!  I've done a little mucking around with the networking
code, i.e., no promises, but maybe I can come up with a fix.

-- 
Bob Tracy                                            rct@frus.com
-----------------------------------------------------------------
 "We might not be in hell, but we can see the gates from here."
 --Phoenix resident, Summer of 2000
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
