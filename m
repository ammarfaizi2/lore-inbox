Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129773AbQLNXKW>; Thu, 14 Dec 2000 18:10:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133089AbQLNXKM>; Thu, 14 Dec 2000 18:10:12 -0500
Received: from gherkin.sa.wlk.com ([192.158.254.49]:58372 "HELO
	gherkin.sa.wlk.com") by vger.kernel.org with SMTP
	id <S129773AbQLNXKJ>; Thu, 14 Dec 2000 18:10:09 -0500
Message-Id: <m146h2G-0005keC@gherkin.sa.wlk.com>
From: rct@gherkin.sa.wlk.com (Bob_Tracy)
Subject: Re: ip_defrag is broken (was: Re: test12 lockups -- need feedback)
To: linux-kernel@vger.kernel.org
Date: Thu, 14 Dec 2000 16:39:36 -0600 (CST)
CC: davem@redhat.com, mhaque@haque.net, ionut@moisil.cs.columbia.edu
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

...and then I wrote:
> This is consistent with the lockup I reported several hours ago.
> In the case of my "unstable" 2.4.0-test12 machine where "startx"
> worked fine for "root" but not for a normal user, the "root"
> account is local.  The normal user account home directories are
> NFS mounted :-(.

I tried the submitted patch for ip_fragment.c, and there's still
no joy on that one unstable machine in my sample set.  At this
point, I should probably go back through all the pre-12 patches
and see if the problem scope can be narrowed a bit.

-- 
Bob Tracy
rct@frus.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
