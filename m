Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161080AbWBPNct@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161080AbWBPNct (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 08:32:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161085AbWBPNct
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 08:32:49 -0500
Received: from webbox4.loswebos.de ([213.187.93.205]:18142 "EHLO
	webbox4.loswebos.de") by vger.kernel.org with ESMTP
	id S1161080AbWBPNct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 08:32:49 -0500
Date: Thu, 16 Feb 2006 14:32:52 +0100
From: Marc Koschewski <marc@osknowledge.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Marc Koschewski <marc@osknowledge.org>,
       Ross Vandegrift <ross@jose.lug.udel.edu>,
       Christian <christiand59@web.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc: CIFS reproducibly freezes the computer
Message-ID: <20060216133251.GB5939@stiffy.osknowledge.org>
References: <20060214135016.GC10701@stusta.de> <200602141659.40176.christiand59@web.de> <20060214164002.GC5905@stiffy.osknowledge.org> <20060214184708.GA29656@lug.udel.edu> <20060215133523.GA6628@stiffy.osknowledge.org> <20060216121123.GD3511@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060216121123.GD3511@stusta.de>
X-PGP-Fingerprint: D514 7DC1 B5F5 8989 083E  38C9 5ECF E5BD 3430 ABF5
X-PGP-Key: http://www.osknowledge.org/~marc/pubkey.asc
X-Operating-System: Linux stiffy 2.6.16-rc3-marc-gd89b8f40-dirty
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Adrian Bunk <bunk@stusta.de> [2006-02-16 13:11:23 +0100]:

> On Wed, Feb 15, 2006 at 02:35:23PM +0100, Marc Koschewski wrote:
> > * Ross Vandegrift <ross@lug.udel.edu> [2006-02-14 13:47:08 -0500]:
> > 
> > > On Tue, Feb 14, 2006 at 05:40:03PM +0100, Marc Koschewski wrote:
> > > > Is that maybe dependant on _what_ version of Samba is running on the receiving
> > > > end?
> > > 
> > > I've seen it copying to Windows 2k3.  Only uploading large files, and
> > > it's not every time.  I'd say 50% of the time, my box freezes when
> > > copying something around 100MiB or larger.
> > > 
> > > IIRC, my workstation at the office is running 2.6.15.1 or .4.
> > 
> > I moved to CIFS because SMB didn't work well for me, as well as did NFS. Both
> > seems to stall in a way, I could never really reproduce. But CIFS is very stable
> > over here. Never ever had a problem with it, whereas both NFS and SMB are likely
> > to cause trouble at least once a week. Without log records, without any chance
> > of recovery. Mostly hard-freezes.
> 
> The problems are often error paths.
> 
> I might be running in some unusual error paths in CIFS, and the same 
> might be true for you in the SMB and NFS cases.
> 
> The SMB file system in the kernel is unfrtunately unmaintained, but NFS 
> is well maintained. Have you sent a bug report for your NFS problems 
> similar to my bug report for my CIFS problems?

No, I didn't. That's was not because I was lazy (and dude, I was lazy back then
when it came to reporting bugs that were not in my software). I just could not
reproduce the phenomenon. It was SMB as well as NFS. No matter what file size
(we tried any size you can think of), no logs entries (neither client nor server),
no IPv4/IPv6 specific thing (we tried both), no matter what serving OS (Linux,
Mac OS X), no matter if the server was busy with other client or not... we tried
months, and I _mean_ months, to reproduce this. No chance. The s**t happened
always when you thought it's impossible to ever come back. Moreover, it was some
sort of personal fight of me against the networking guys over here. I'm the only
one in the company developing on a Linux machine. All others do on Windows, BSD
or Mac OS X (yes, I know it's a BSD). They always wanted me to go over to BSD or
even _Windows_ (!!!) and then CIFS finally got me back on the road again. NFS
servers are currently not running. They were just run for me. No, that I use
CIFS, there's just no need...

Maybe, when I have time I'll try to convince the to setup the NFS thing again
and let me run tests on it with various kernels and maybe some of your guys help
(testcases, scenarios, ...).

Marc
