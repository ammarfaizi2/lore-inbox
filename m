Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289089AbSCCVrA>; Sun, 3 Mar 2002 16:47:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288174AbSCCVqu>; Sun, 3 Mar 2002 16:46:50 -0500
Received: from dsl-213-023-040-044.arcor-ip.net ([213.23.40.44]:3981 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S289046AbSCCVqh>;
	Sun, 3 Mar 2002 16:46:37 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andrea Arcangeli <andrea@suse.de>, Bill Davidsen <davidsen@tmr.com>
Subject: Re: 2.4.19pre1aa1
Date: Sun, 3 Mar 2002 22:38:34 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Mike Fedyk <mfedyk@matchmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020301013056.GD2711@matchmail.com> <Pine.LNX.3.96.1020228221750.3310D-100000@gatekeeper.tmr.com> <20020302030615.G4431@inspiron.random>
In-Reply-To: <20020302030615.G4431@inspiron.random>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16hdgg-0000Py-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On March 2, 2002 03:06 am, Andrea Arcangeli wrote:
> On Thu, Feb 28, 2002 at 10:26:48PM -0500, Bill Davidsen wrote:
> > rather than patches. But there are a lot more small machines (which I feel
> > are better served by rmap) than large. I would like to leave the jury out
> 
> I think there's quite some confusion going on from the rmap users, let's
> clarify the facts.
> 
> The rmap design in the VM is all about decreasing the complexity of
> swap_out on the huge boxes (so it's all about saving CPU), by slowing
> down a big lots of fast common paths like page faults and by paying with
> some memory too. See the lmbench numbers posted by Randy after applying
> rmap to see what I mean.

Do you know any reason why rmap must slow down the page fault fast, or are
you just thinking about Rik's current implementation?  Yes, rmap has to add
a pte_chain entry there, but it can be a direct pointer in the unshared case
and the spinlock looks like it can be avoided in the common case as well.

-- 
Daniel
