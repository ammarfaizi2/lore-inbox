Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269114AbUINCWm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269114AbUINCWm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 22:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268834AbUINCUd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 22:20:33 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:32408 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S269130AbUINCSH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 22:18:07 -0400
Subject: Re: [PATCH] Realtime LSM
From: Lee Revell <rlrevell@joe-job.com>
To: Chris Wright <chrisw@osdl.org>
Cc: kronos@kronoz.cjb.net, linux-kernel <linux-kernel@vger.kernel.org>,
       joq@io.com, torbenh@gmx.de
In-Reply-To: <20040913163448.T1973@build.pdx.osdl.net>
References: <20040912155035.GA17972@dreamland.darkstar.lan>
	 <1095117752.1360.5.camel@krustophenia.net>
	 <20040913163448.T1973@build.pdx.osdl.net>
Content-Type: text/plain
Message-Id: <1095128285.1752.4.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 13 Sep 2004 22:18:06 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-09-13 at 19:34, Chris Wright wrote:
> * Lee Revell (rlrevell@joe-job.com) wrote:
> > +  # modprobe realtime mlock=0
> > +
> > +  Grants realtime scheduling privileges without the ability to lock
> > +  memory using mlock() or mlockall() system calls.  This option can be
> > +  used in conjunction with any of the other options.
> > +

> The mlock() bit is unecessary now.  Use rlimits on the audio users.
> Which leaves realtime bits, plus others.  I had a more generic module
> (per-capability) that would be a superset of this.  Perhaps that's a
> better fit.  I'm travelling this week, so forgive the spotty replies.

I think this would be fine.  All we need is a way to allow users to run
SCHED_FIFO processes and use mlockall() without being root and without
having to patch the kernel.  It's a pretty simple requirement.

Lee

