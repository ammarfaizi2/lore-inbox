Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129464AbRBXR3f>; Sat, 24 Feb 2001 12:29:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129375AbRBXR3Z>; Sat, 24 Feb 2001 12:29:25 -0500
Received: from roc-24-95-203-215.rochester.rr.com ([24.95.203.215]:19466 "EHLO
	d185fcbd7.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S129333AbRBXR3Q>; Sat, 24 Feb 2001 12:29:16 -0500
Date: Sat, 24 Feb 2001 12:28:38 -0500
From: Chris Mason <mason@suse.com>
To: Arjan Filius <iafilius@xs4all.nl>, Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: reiserfs: still problems with tail conversion
Message-ID: <845760000.983035718@tiny>
In-Reply-To: <Pine.LNX.4.30.0102241613140.1185-100000@sjoerd.sjoerdnet>
X-Mailer: Mulberry/2.0.6b4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Saturday, February 24, 2001 04:45:04 PM +0100 Arjan Filius
<iafilius@xs4all.nl> wrote:

> Hello,
> 
> I tried Erik's trigger-program.
> 
> After some test i thing it's memory related, and it seems to match the
> other reports i saw on lkm.
> With my 384M ram i was not able te reproduce it.
> With "mem=32M" linux hang while starting a test oracle-db.
> However i tried (not repeated tests, and after a fresh reboot):
> ram=128M	; Triggered


Ah, I did not get it at 128M, but did get the messages at 32MB.  The read
stage of the test program does not close the fd by the way, so some of the
errors were from that (but not all).

So, there must be somewhere else that we are screwing up the tail
conversion, I'll see what I can find.

-chris

