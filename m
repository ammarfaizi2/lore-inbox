Return-Path: <linux-kernel-owner+w=401wt.eu-S964891AbWLTHJa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964891AbWLTHJa (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 02:09:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964894AbWLTHJa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 02:09:30 -0500
Received: from mail.gmx.net ([213.165.64.20]:48959 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S964891AbWLTHJ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 02:09:29 -0500
X-Authenticated: #14349625
Subject: Re: BUG: wedged processes, test program supplied
From: Mike Galbraith <efault@gmx.de>
To: Albert Cahalan <acahalan@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <787b0d920612192205v2d650361r4f737c41aa1d3a92@mail.gmail.com>
References: <787b0d920612191846t5a51a2e4ld4101b26ca7a8413@mail.gmail.com>
	 <1166593200.1614.8.camel@Homer.simpson.net>
	 <787b0d920612192205v2d650361r4f737c41aa1d3a92@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 20 Dec 2006 08:09:25 +0100
Message-Id: <1166598565.1614.53.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-12-20 at 01:05 -0500, Albert Cahalan wrote:
> On 12/20/06, Mike Galbraith <efault@gmx.de> wrote:
> > On Tue, 2006-12-19 at 21:46 -0500, Albert Cahalan wrote:
> > > Somebody PLEASE try this...
> >
> > I was having enough fun with cloninator (which was whitespace munged
> > btw).
> 
> Anything stuck? Besides refusing to die, that beast slays debuggers
> left and right. I just need to add execve of /proc/self/exe and a massive
> storm of signals on the alternate stack.

Usually, I can kill the misbehaving strace or abandoned cloninators if
it decides to take a hike, but sometimes it leaves corpses lying around.

> Oh. I wanted to be sure you'd see the problem. Did you have
> some... difficulty? A plain old ^C should make things stop.
> The second test program is like the first, but missing SIGCHLD
> >from the clone flags, and hopefully not whitespace-mangled.
> 
> Note that the test program is not normally a fork bomb.
> It self-limits itself to 42 tasks via a lock in shared memory.
> If things are working OK, you should see no more than
> about 60 tasks.

I didn't take any countermeasures.. had ~27000 zombies.

	-Mike

