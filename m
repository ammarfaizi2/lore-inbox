Return-Path: <linux-kernel-owner+w=401wt.eu-S932097AbXAFTXY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097AbXAFTXY (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 14:23:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932104AbXAFTXY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 14:23:24 -0500
Received: from shards.monkeyblade.net ([192.83.249.58]:60561 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932100AbXAFTXX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 14:23:23 -0500
Subject: Re: [KORG] Re: kernel.org lies about latest -mm kernel
From: "J.H." <warthog9@kernel.org>
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Willy Tarreau <w@1wt.eu>, Andrew Morton <akpm@osdl.org>,
       Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
       hpa@zytor.com, webmaster@kernel.org
In-Reply-To: <20070106103331.48150aed.randy.dunlap@oracle.com>
References: <20061214223718.GA3816@elf.ucw.cz>
	 <20061216094421.416a271e.randy.dunlap@oracle.com>
	 <20061216095702.3e6f1d1f.akpm@osdl.org> <458434B0.4090506@oracle.com>
	 <1166297434.26330.34.camel@localhost.localdomain>
	 <20061219063413.GI24090@1wt.eu>
	 <1166511171.26330.120.camel@localhost.localdomain>
	 <20070106103331.48150aed.randy.dunlap@oracle.com>
Content-Type: text/plain
Date: Sat, 06 Jan 2007 11:21:15 -0800
Message-Id: <1168111275.2505.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's an issue of load, and both machines are running 'hot' so to speak.
When the loads on the machines climbs our update rsyncs take longer to
complete (considering that our loads are completely based on I/O this
isn't surprising).  More or less nothing has changed since:
http://lkml.org/lkml/2006/12/14/347 with the exception that git & gitweb
are no longer the concern we have (the caching layer I put into
kernel.org seems to be taking care of the worst problems we were seeing
and I have a couple more to put up this weekend), right now it's getting
loads between the two machines load evened out and lowering the number
of allowed rsyncs on each machine to better bound the load problem.

- John

On Sat, 2007-01-06 at 10:33 -0800, Randy Dunlap wrote:
> On Mon, 18 Dec 2006 22:52:51 -0800 J.H. wrote:
> 
> > On Tue, 2006-12-19 at 07:34 +0100, Willy Tarreau wrote:
> > > On Sat, Dec 16, 2006 at 11:30:34AM -0800, J.H. wrote:
> > > (...)
> > > 
> > > > So we know the problem is there, and we are working on it - we are
> > > > getting e-mails about it if not daily than every other day or so.  If
> > > > there are suggestions we are willing to hear them - but the general
> > > > feeling with the admins is that we are probably hitting the biggest
> > > > problems already.
> > > 
> > > BTW, yesterday my 2.4 patches were not published, but I noticed that
> > > they were not even signed not bziped on hera. At first I simply thought
> > > it was related, but right now I have a doubt. Maybe the automatic script
> > > has been temporarily been disabled on hera too ?
> > 
> > The script that deals with the uploads also deals with the packaging -
> > so yes the problem is related.
> 
> and with the finger_banner and version info on www.kernel.org page?
> 
> They currently say:
> 
> The latest stable version of the Linux kernel is:           2.6.19.1
> The latest prepatch for the stable Linux kernel tree is:    2.6.20-rc3
> The latest snapshot for the stable Linux kernel tree is:    2.6.20-rc3-git4
> The latest 2.4 version of the Linux kernel is:              2.4.34
> The latest 2.2 version of the Linux kernel is:              2.2.26
> The latest prepatch for the 2.2 Linux kernel tree is:       2.2.27-rc2
> The latest -mm patch to the stable Linux kernels is:        2.6.20-rc2-mm1
> 
> 
> but there are 2.6.20-rc3-git[567] and 2.6.20-rc3-mm1 out there,
> so when is the finger version info updated?
> 
> Thanks,
> ---
> ~Randy

