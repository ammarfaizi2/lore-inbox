Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287632AbSAUSAo>; Mon, 21 Jan 2002 13:00:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287633AbSAUSAf>; Mon, 21 Jan 2002 13:00:35 -0500
Received: from smtp1.ndsu.NoDak.edu ([134.129.111.146]:779 "EHLO
	smtp1.ndsu.nodak.edu") by vger.kernel.org with ESMTP
	id <S287632AbSAUSAc>; Mon, 21 Jan 2002 13:00:32 -0500
Subject: Re: Athlon PSE/AGP Bug
From: Reid Hekman <reid.hekman@ndsu.nodak.edu>
To: Andrea Arcangeli <andrea@suse.de>
Cc: lkml <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Ed Sweetman <ed.sweetman@wmich.edu>
In-Reply-To: <20020121175410.G8292@athlon.random>
In-Reply-To: <1011610422.13864.24.camel@zeus>
	<20020121.053724.124970557.davem@redhat.com> 
	<20020121175410.G8292@athlon.random>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 21 Jan 2002 11:57:59 -0600
Message-Id: <1011635883.15878.42.camel@zeus>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-01-21 at 10:54, Andrea Arcangeli wrote:
> On Mon, Jan 21, 2002 at 05:37:24AM -0800, David S. Miller wrote:
> >    That errata lists all Athlon Thunderbirds as affected and all Athlon
> >    Palominos except for stepping A5. 
...
> > The funny part is, if this published errata is the problem, it cannot
> > be a problem under Linux since we never invalidate 4MB pages.  We
> > create them at boot time and they never change after that.
> 
> correct, furthmore it cannot even trigger if you invlpg with an address
> page aligned (4mbyte aligned in this case) like we would always do in
> linux anyways, we never use invlpg on misaligned addresses, no matter if
> the page is a 4M or a 4k page.  And I guess with PAE enabled it cannot
> even trigger in first place (it speaks only about 4M pages, pae only
> provides 2M pages instead).
> 
> I think this is a very very minor issue, I doubt anybody ever triggered
> it in real life with linux.

Thanks for the clarification, I run a few systems with such CPU's but
they don't exhibit the problem. I don't run Gentoo, just RH 7.(12) and
Debian Woody with recent 2.4 vanilla kernels, all of which run AGP, but
with a mix of ATI and Nvidia cards.

On Mon, 2002-01-21 at 12:26, Ed Sweetman wrote:
> Damn you gotta love slashdot. It's like the Internet's smut mag.  If
> their news is going to be so old it should be because they're actually
> looking into the story they're posting with some kind of review
> process.

Well I saw this on LinuxToday before it hit slashdot (it was mostly
inaccessible after that).  Gentoo's explanation made sense, they claimed
to have spoken with Terrence Ripperda at Nvidia, Andrew Morton, and Alan
Cox. They also claimed this was a generic CPU bug affecting Linux -- the
same bug that was resolved with a workaround a year ago in Windows.

Unfortunately, the Technical note describing the Windows fix AMD
published is incredibly vague and doesn't specify if it is in fact a CPU
bug or some voodoo specific to Windows 2000.

Certainly there are some questions regarding the true impact of this bug
if any -- that's why I asked here. Slashdot reporting it just blows
things out of proportion. I wouldn't take Slashdot's word for anything,
but nor would I dismiss reports of problems out of hand just because
Slashdot picks up on it.

Regards,
Reid

