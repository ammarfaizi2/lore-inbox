Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316492AbSFEWbz>; Wed, 5 Jun 2002 18:31:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316523AbSFEWby>; Wed, 5 Jun 2002 18:31:54 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:65272 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S316492AbSFEWbx>; Wed, 5 Jun 2002 18:31:53 -0400
Date: Wed, 5 Jun 2002 18:31:52 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Steve Lord <lord@sgi.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [RFC] 4KB stack + irq stack for x86
Message-ID: <20020605183152.H4697@redhat.com>
In-Reply-To: <20020604225539.F9111@redhat.com> <1023315323.17160.522.camel@jen.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 05, 2002 at 05:15:23PM -0500, Steve Lord wrote:
> Just what are the tasks you normally run - and how many code
> paths do you think there are out there which you do not run. XFS
> might get a bit stack hungry in places, we try to keep it down,
> but when you get into file system land things can stack up quickly:

You already lose in that case today, as multiple irqs may come in 
from devices and eat up the stack.  The whole thing that led me down 
this line is seeing it happen in real life.  What remains to be done 
is to write an automated stack depth checker based on possible call 
chains that will calculate the maximum possible stack depth.  I've 
already got scripts for dumping the top stack users, it's a matter 
of writing code that can show us the possible call chains.

		-ben
