Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261602AbSJNMOA>; Mon, 14 Oct 2002 08:14:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261609AbSJNMOA>; Mon, 14 Oct 2002 08:14:00 -0400
Received: from sccrmhc03.attbi.com ([204.127.202.63]:21441 "EHLO
	sccrmhc03.attbi.com") by vger.kernel.org with ESMTP
	id <S261602AbSJNMN6>; Mon, 14 Oct 2002 08:13:58 -0400
Reply-To: <markknecht@attbi.com>
From: "Mark Knecht" <markknecht@attbi.com>
To: <linux-audio-dev@music.columbia.edu>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: [linux-audio-dev] latency performance of 2.4 and 2.5...
Date: Mon, 14 Oct 2002 05:20:12 -0700
Message-ID: <NCBBIAJIAJDLHEFAALBMEENGDEAA.markknecht@attbi.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
In-Reply-To: <3DAA85D8.70D9FF25@folkwang-hochschule.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörn,
   I did a little work on this file system choice a couple of weeks ago. My
results said stay away from ext3. I'm now using reiserfs.

   There is a directory with some results on the same drive (different
partitions) using ext2, ext3 and reiserfs. ext3 and reiserfs also have data
on how ext2 performed on that partition, but it didn't matter. Each
partition was mostly the same.

http://www.controlnet.com/~makeMusic/disklatency/fstest/

   FYI - I had to drop Gnome as it had too many things going on in the
background. These results were done using fluxbox.

Mark

-----Original Message-----
From: linux-audio-dev-admin@music.columbia.edu
[mailto:linux-audio-dev-admin@music.columbia.edu]On Behalf Of Joern
Nettingsmeier
Sent: Monday, October 14, 2002 1:53 AM
To: Andrew Morton
Cc: linux-audio-dev@music.columbia.edu; linux-kernel@vger.kernel.org
Subject: Re: [linux-audio-dev] latency performance of 2.4 and 2.5...


Andrew Morton wrote:
>
> Joern Nettingsmeier wrote:
> >
> > some new interesting results with 2.5.42:
> >
> > http://spunk.dnsalias.org/latencytest/2.5.42/2x256.html
> >
> > overall much worse, *but* greatly reduced latency peaks (max. 6 ms) as
> > compared to 2.5.41:
> >
> > http://spunk.dnsalias.org/latencytest/2.5.41/2x256.html
> >
> > here the peaks easily reach 13 ms.
>
> Rather depends on the filesystem.  ext3 does its own write scheduling,
> and does stuff inside lock_kernel().  It needs a couple of scheduling
> points I guess.
>
> I'd expect ext2 to work OK with preemption, but nobody has really
> looked yet.  Unless you're using ftruncate() (grr.)

oh, i should have stated i'm using reiserfs on /, /usr and /var (var
being a softraid-0).


--
Jörn Nettingsmeier
Kurfürstenstr 49, 45138 Essen, Germany
http://spunk.dnsalias.org (my server)
http://www.linuxdj.com/audio/lad/ (Linux Audio Developers)


