Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132794AbRC2Qqn>; Thu, 29 Mar 2001 11:46:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132791AbRC2Qqe>; Thu, 29 Mar 2001 11:46:34 -0500
Received: from m341-mp1-cvx1a.col.ntl.com ([213.104.69.85]:36358 "EHLO
	[213.104.69.85]") by vger.kernel.org with ESMTP id <S132787AbRC2QqU>;
	Thu, 29 Mar 2001 11:46:20 -0500
To: David Balazic <david.balazic@uni-mb.si>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
   <linux-laptop@vger.kernel.org>, <apm@linuxcare.com.au>,
   <apenwarr@worldvisions.ca>, <sfr@linuxcare.com.au>
Subject: Re: kernel apm code
In-Reply-To: <3AC0A679.DFA9F74B@uni-mb.si> <"m28zlr58w9.fsf"@boreas.yi.org>
	<3AC1C406.652D0207@uni-mb.si> <"m2bsqmlyrh.fsf"@boreas.yi.org>
	<3AC2FF70.CA2317B6@uni-mb.si>
From: John Fremlin <chief@bandits.org>
Date: 29 Mar 2001 17:44:25 +0100
In-Reply-To: David Balazic's message of "Thu, 29 Mar 2001 11:25:04 +0200"
Message-ID: <m24rwcjziu.fsf@boreas.yi.org.>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (GTK)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 David Balazic <david.balazic@uni-mb.si> writes:

> John Fremlin wrote:

[...]

> > > To implement off-button you only need the APM_IOC_REJECT ioctl and
> > 
> > The problem on my computer with my (re)implementation of
> > APM_IOC_REJECT is that the screen goes into powersaving when the user
> > suspend is received, then turns it back on when APM_IOC_REJECT is sent
> > by apmd.
> 
> What is wrong with that ?

> Suspend is requested -> suspend is executed

> Suspend is canceled (rejected) -> suspend is canceled
> 
> Seems perfectly OK to me.

The sequence is in fact: suspend requested by BIOS -> suspend accepted
by kernel -> SUSPEND -> suspend rejected by apmd which is passed on by
kernel to BIOS -> REJECT=RESUME (if I understand correctly, this is
what seems to happen).

Sequence should be as in pmpolicy patch: suspend requested by BIOS ->
/sbin/powermanger decides to reject -> REJECT

[...]

> > Anyway it is fixed in my pmpolicy patch, and I don't need no
> > daemon so the code is a lot cleaner and simpler (no binary magic
> > number interfaces).
> 
> But there should be no policy in the kernel ! ;-)

Read the patch. Read the webpage:

        http://john.snoop.dk/programs/linux/offbutton

There is no policy in kernel.

-- 

	http://www.penguinpowered.com/~vii
