Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268256AbTGINn5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 09:43:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268258AbTGINn5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 09:43:57 -0400
Received: from mail.ithnet.com ([217.64.64.8]:32523 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S268256AbTGINn2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 09:43:28 -0400
Date: Wed, 9 Jul 2003 15:58:03 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Oleg Drokin <green@namesys.com>
Cc: mason@suse.com, linux-kernel@vger.kernel.org
Subject: Re: 2.4.22-pre3 and reiserfs boot problem
Message-Id: <20030709155803.2d1569a8.skraw@ithnet.com>
In-Reply-To: <20030709134837.GJ18307@namesys.com>
References: <20030706183453.74fbfaf2.skraw@ithnet.com>
	<1057515223.20904.1315.camel@tiny.suse.com>
	<20030709140138.141c3536.skraw@ithnet.com>
	<1057757764.26768.170.camel@tiny.suse.com>
	<20030709134837.GJ18307@namesys.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jul 2003 17:48:37 +0400
Oleg Drokin <green@namesys.com> wrote:

> Hello!
> 
> On Wed, Jul 09, 2003 at 09:36:04AM -0400, Chris Mason wrote:
> > > > Is reiserfs on your root drive?  If not can you please boot into single
> > > > user mode, enable sysrq, try the mount again and get the decoded output
> > > > from sysrq-p and sysrq-t if it hangs.
> > > I tried to produce some useful output but failed. Additionals I found:
> > > - pre3-ac1 has the same problem
> > > - the box _hangs_ in fact, no sysrq is working.
> > >   (you need hw-reset to revive the box)
> 
> This complete hang is _very_ suspicious. Usually you cannot achieve such
> results without touching hardware.

Well, I did a few more tries and it looks like this:
- enter mount command
- short blinking on the RAID disks
- about 1/2 second later box hangs
 
> > Step one is to figure out if the problem is reiserfs or 3ware.  Instead
> > of mounting the filesystem, run debugreiserfs -d /dev/xxxx > /dev/null
> > and see if you still hang.
> > This will read the FS metadata and should generate enough io to trigger
> > the hang if it is a 3ware problem.

Ok, I tried this. debugreiserfs runs without any problems. Disks show quite an
activity, the whole thing lasts 1-2 minutes.

mount afterwards shows the same hang.

> Or if this one suceeds, then may be reiserfsck --check /dev/xxxx to get
> journal replayed. This is in case access pattern matters.

I can try that, too. What do you expect to see?

Regards,
Stephan
