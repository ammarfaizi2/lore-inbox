Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266030AbTGINeF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 09:34:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268249AbTGINeE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 09:34:04 -0400
Received: from angband.namesys.com ([212.16.7.85]:20647 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S266030AbTGINeA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 09:34:00 -0400
Date: Wed, 9 Jul 2003 17:48:37 +0400
From: Oleg Drokin <green@namesys.com>
To: Chris Mason <mason@suse.com>
Cc: Stephan von Krawczynski <skraw@ithnet.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.22-pre3 and reiserfs boot problem
Message-ID: <20030709134837.GJ18307@namesys.com>
References: <20030706183453.74fbfaf2.skraw@ithnet.com> <1057515223.20904.1315.camel@tiny.suse.com> <20030709140138.141c3536.skraw@ithnet.com> <1057757764.26768.170.camel@tiny.suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1057757764.26768.170.camel@tiny.suse.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Wed, Jul 09, 2003 at 09:36:04AM -0400, Chris Mason wrote:
> > > Is reiserfs on your root drive?  If not can you please boot into single
> > > user mode, enable sysrq, try the mount again and get the decoded output
> > > from sysrq-p and sysrq-t if it hangs.
> > I tried to produce some useful output but failed. Additionals I found:
> > - pre3-ac1 has the same problem
> > - the box _hangs_ in fact, no sysrq is working.
> >   (you need hw-reset to revive the box)

This complete hang is _very_ suspicious. Usually you cannot achieve such
results without touching hardware.

> > - I can see no disk activity on the 3ware RAID in question

After the lockup? This is kind of expected ;)

> > - It always shows up, completely reproducable
> > - It shows during boot and during single- or multiuser (mount from console)
> Step one is to figure out if the problem is reiserfs or 3ware.  Instead
> of mounting the filesystem, run debugreiserfs -d /dev/xxxx > /dev/null
> and see if you still hang.
> This will read the FS metadata and should generate enough io to trigger
> the hang if it is a 3ware problem.

Or if this one suceeds, then may be reiserfsck --check /dev/xxxx to get
journal replayed. This is in case access pattern matters.

Bye,
    Oleg
