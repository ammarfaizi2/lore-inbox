Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261417AbTENCcd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 22:32:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261747AbTENCcd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 22:32:33 -0400
Received: from miranda.zianet.com ([216.234.192.169]:64004 "HELO
	miranda.zianet.com") by vger.kernel.org with SMTP id S261417AbTENCcb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 22:32:31 -0400
Subject: Re: 2.6 must-fix list, v2
From: Steven Cole <elenstev@mesatop.com>
To: "Shaheed R. Haque" <srhaque@iee.org>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1052865981.3ec175bd59bc9@netmail.pipex.net>
References: <1050146434.3e97f68300fff@netmail.pipex.net>
	 <1050177383.3e986f67b7f68@netmail.pipex.net>
	 <1050177751.2291.468.camel@localhost>
	 <1050222609.3e992011e4f54@netmail.pipex.net>
	 <1050244136.733.3.camel@localhost>
	 <1052826556.3ec0dbbc1d993@netmail.pipex.net>
	 <20030513130257.78ab1a2e.akpm@digeo.com>
	 <1052865981.3ec175bd59bc9@netmail.pipex.net>
Content-Type: text/plain
Organization: 
Message-Id: <1052880133.21270.131.camel@spc>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4-1.1mdk 
Date: 13 May 2003 20:42:13 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-05-13 at 16:46, Shaheed R. Haque wrote:
> Quoting Andrew Morton <akpm@digeo.com>:
> 
> > "Shaheed R. Haque" <srhaque@iee.org> wrote:
> > >
> > > - Add ability to restrict the the default CPU affinity mask so that 
> > >  sys_setaffinity() can be used to implement exclusive access to a CPU.
> > 
> > Why is this useful?
> 
> Because it allows one to dedicate a CPU to a process. For example, lets say you
> have a quad processor,and want to run joe-random stuff on CPU 0, but a
> specialised program on CPUs 1, 2, 3 that does not want to compete with
> joe-random stuff.
> 
> With sys_setaffinity(), one can set the affinity of the special program to
> 0xe...but the default affinity for all the joe-random stuff is still 0xf (from
> cpu_online_map)! Since its impractical to to modify every single joe-random
> executable to set its affinity to 0x1, a way is needed to set the default. The
> logical place is in init(), a.k.a. kernel/fork.c.
> 
> I hope that make sense.
> 
> Thanks, Shaheed
> 

Is this related or not to processor shielding used by RedHawk Linux?
Here is a link to their page:

http://www.ccur.com/realtime/sys_rdhwklnx.html

I saw a presentation by these guys over a year ago.  I'm not sure what
they're up to now.

Steven

