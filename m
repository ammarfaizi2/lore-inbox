Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267493AbTAXBdD>; Thu, 23 Jan 2003 20:33:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267496AbTAXBdB>; Thu, 23 Jan 2003 20:33:01 -0500
Received: from adsl-67-64-81-217.dsl.austtx.swbell.net ([67.64.81.217]:11950
	"HELO digitalroadkill.net") by vger.kernel.org with SMTP
	id <S267493AbTAXBc5>; Thu, 23 Jan 2003 20:32:57 -0500
Subject: Re: AW: 2.4.20 CPU lockup - Now with OOPS message
From: GrandMasterLee <masterlee@digitalroadkill.net>
To: dk@webcluster.at
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <DIEGIJEABDDLMLKJFCKJCEFLCEAA.dk@webcluster.at>
References: <DIEGIJEABDDLMLKJFCKJCEFLCEAA.dk@webcluster.at>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Digitalroadkill.net
Message-Id: <1043372432.12857.3.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 23 Jan 2003 19:40:33 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-01-23 at 18:11, Daniel Khan wrote:
> Hi,
> 
> > > I reported frequently system lockups today.
> > > Now after some playing around (cause I don't know anything about kernel
> > > debugging - Thanks to Mark Hahn for the tipps)
> > > I found a way to reproduce the lock and to get the OOPS.
> [..]
> 
> > Can I ask how you reproduced this? I've got several systems with TG3's
> > and they only get lockups during network backups.
> 
> httpd session on the host which has big logfiles to get them changed.
> Starting rsync to sync the logfiles and other stuff to the backup host.
> 
> Sometimes I have to retry 2-3 times but it crashes very reliable.
> It's quite the same as the network backups you mentioning.

We use rsync to do our backups. I've been getting lines in my backup
server kernel and dmesg like this:

TCP: Treason uncloaked! Peer 10.1.1.40:37859/873 shrinks window
2430745930:2430747378. Repaired.
TCP: Treason uncloaked! Peer 10.1.1.40:37859/873 shrinks window
2430745930:2430747378. Repaired.


I was able to successfully reproduce this error in a test setup, but not
the crashes. I'm curious if maybe I just start up too many instances of
rsync and see what happens.

Any particular method or size of files, etc, in reproducing this would
be greatly beneficial. TIA

> Daniel Khan
