Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261827AbRE2VCG>; Tue, 29 May 2001 17:02:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261913AbRE2VB4>; Tue, 29 May 2001 17:01:56 -0400
Received: from ncc1701.cistron.net ([195.64.68.38]:17671 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP
	id <S261855AbRE2VBv>; Tue, 29 May 2001 17:01:51 -0400
From: miquels@cistron-office.nl (Miquel van Smoorenburg)
Subject: Re: serial console problems under 2.4.4/5
Date: Tue, 29 May 2001 21:01:50 +0000 (UTC)
Organization: Cistron Internet Services B.V.
Message-ID: <9f12nu$dig$1@ncc1701.cistron.net>
In-Reply-To: <yrxofscdnpj.fsf@terra.mcs.anl.gov> <9f0qoj$ttr$1@ncc1701.cistron.net> <yrxsnhot1ec.fsf@terra.mcs.anl.gov>
X-Trace: ncc1701.cistron.net 991170110 13904 195.64.65.67 (29 May 2001 21:01:50 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test75 (Feb 13, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <yrxsnhot1ec.fsf@terra.mcs.anl.gov>,
Narayan Desai <desai@mcs.anl.gov> wrote:
>>>>>> "Mike" == Miquel van Smoorenburg <miquels@cistron-office.nl> writes:
>
>Mike> In article <yrxofscdnpj.fsf@terra.mcs.anl.gov>,
>Mike> Narayan Desai <desai@mcs.anl.gov> wrote:
>>> Hi. I have started having serial console problems in the last bunch
>>> of kernel releases. I have tried various 2.4.4 and 2.4.5 ac kernels
>>> (up to and including 2.4.5-ac4) and the problem has persisted. The
>>> problem is basically that serial console doesn't recieve.
>
>Mike> The serial driver now pays attention to the CREAD bit. Sysvinit
>Mike> clears it, so that's where it goes wrong.
>
>Mike> I don't think this change should have gone into a 'stable'
>Mike> kernel version. 2.5.0 would have been fine, not 2.4.4

Okay it was 2.4.3 when it went in

>How would I go about resetting this so that serial console worked
>again? thanks...

Fix sysvinit. Oh and all getty programs etc - everything that
mucks around with termios.

Alternatively revert the change to drivers/char/serial.c

See also http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg42426.html

Oh *ahem* I just read the entire thread again and I remembered it
wrong. It's not the CREAD handling perse, it's something else that
has changed that caused this, but it appears that a solution
hasn't been found yet. Except for fixing all user-space programs.
Sysvinit, agetty, busybox etc etc

Okay so ignore my earlier comments. Sorry.

Mike.

