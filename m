Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275363AbTHSFuK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 01:50:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275384AbTHSFuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 01:50:10 -0400
Received: from mail.cid.net ([193.41.144.34]:49290 "EHLO mail.cid.net")
	by vger.kernel.org with ESMTP id S275363AbTHSFuG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 01:50:06 -0400
Date: Tue, 19 Aug 2003 07:43:27 +0200
From: Stefan Foerster <stefan@stefan-foerster.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Very bad interactivity with 2.6.0 and SCSI disks (aic7xxx)
Message-ID: <20030819054327.GA8674@in-ws-001.cid-net.de>
References: <20030818013243.GB21665@in-ws-001.cid-net.de> <20030817192103.798994d8.akpm@osdl.org> <20030818054851.GA5252@in-ws-001.cid-net.de> <20030817230325.2887ca49.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030817230325.2887ca49.akpm@osdl.org>
X-Now-Playing: Sting - Desert Rose
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[I've sent this mail aleready, but got an error from my MAILER-DAEMON.
Perhaps ist was too large vor lkml, so I'm moving the oprofile output
to a webserver]

* Andrew Morton <akpm@osdl.org> wrote:
> Stefan Foerster <stefan@stefan-foerster.de> wrote:
> > * Andrew Morton <akpm@osdl.org> wrote:
> > > Stefan Foerster <stefan@stefan-foerster.de> wrote:
> > > A kernel profile would be needed to diagnose this.  You could use
> > > readprofile, but as it may be an interrupt problem, the NMI-based oprofile
> > > output would be better.
> > 
> > Is this procedure documented anywhere?

[every information I needed]

I did the following steps:


opcontrol --setup --vmlinux=/usr/src/linux/vmlinux --event=RETIRED_INSNS:100000:0:1:1

Then I used your shell source:

~/shells/oprofileit dd if=/dev/zero of=test bs=1024 count=1048576

opreport -l  /usr/src/linux/vmlinux  > /tmp/1
opreport -ld -D /usr/src/linux/vmlinux  > /tmp/2

During the dd, again the xmms playing a file from an tmpfs froze and
even screen redrawing was very, very slow.

The output of these commands kan be found at:

http://home.in.tum.de/foerstes/oprofile-1
http://home.in.tum.de/foerstes/oprofile-2

Is this information useful in debugging my problem, or should I go and
try again with readprofile or other tools?

Ciao,
Stefan

