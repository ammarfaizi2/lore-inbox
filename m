Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263743AbREYNW2>; Fri, 25 May 2001 09:22:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263744AbREYNWS>; Fri, 25 May 2001 09:22:18 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:61965
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S263743AbREYNWF>; Fri, 25 May 2001 09:22:05 -0400
Date: Fri, 25 May 2001 09:21:26 -0400
From: Chris Mason <mason@suse.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
cc: Hans Reiser <reiser@namesys.com>, Andi Kleen <ak@suse.de>,
        Andreas Dilger <adilger@turbolinux.com>,
        monkeyiq <monkeyiq@users.sourceforge.net>,
        linux-kernel@vger.kernel.org, Nikita Danilov <god@namesys.com>
Subject: Re: Dying disk and filesystem choice.
Message-ID: <208080000.990796886@tiny>
In-Reply-To: <E1533Pf-0005gt-00@the-village.bc.nu>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thursday, May 24, 2001 11:16:58 PM +0100 Alan Cox
<alan@lxorguk.ukuu.org.uk> wrote:

>> IMHO we are not that deep into code freeze anymore. Freevxfs got added
>> in linux-2.4.5-pre*, so I think that a patch that adds a useful feature
>> like badblock support would be OK.
> 
> FreeVxFS changes precisely nothing in the behaviour of any other fs - its
> like adding a new driver.
> 
> Updating Reiserfs requires a lot more care because it has the potential to
> harm existing stable setups

This has been mostly covered, but just in case.  There are two different
freezes, the kernel, and in reiserfs.  The reiserfs part isn't something
Alan or Linus have imposed on us, we just wanted to limit the reiserfs
changes as much as possible during the early kernel releases.

The end result is that some larger scale issues are unfixed (memory
pressure from VM, lost files after a crash), but we have been able to focus
on the critical hoses-my-files/crashes-my-box kinds of bugs.

-chris

