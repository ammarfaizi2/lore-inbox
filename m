Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311587AbSDBMJH>; Tue, 2 Apr 2002 07:09:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311752AbSDBMI5>; Tue, 2 Apr 2002 07:08:57 -0500
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:32015 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S311587AbSDBMIp>; Tue, 2 Apr 2002 07:08:45 -0500
Date: Tue, 2 Apr 2002 14:08:30 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
cc: Tom Holroyd <tomh@po.crl.go.jp>, Andreas Schwab <schwab@suse.de>,
        kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Unknown HZ value! (1908) Assume 1024.
In-Reply-To: <200204010828.g318SUH430119@saturn.cs.uml.edu>
Message-ID: <Pine.LNX.4.33.0204021402280.494-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Apr 2002, Albert D. Cahalan wrote:

> Tim Schmielau writes:
> 
> > I'd still prefer to export only 32 bit of user, nice, and system. This
> > way they overflow in a clearly defined way - the 32 bits we export are
> > exact, only the higher bits are missing.
> 
> The higher bits are absolutely required.
At least on Alpha (with HZ=1024) I definitely agree. At HZ=100 I'm a bit 
uncertain. What I don't want is exporting higher bits that sometimes wrap
and sometimes not.
> 
> There are ways to push the work of doing a 64-bit counter out into the
> proc filesystem and a timer that goes off every 31 bits worth of time.
> I've posted an explanation before; you may search for it if you like.
> 

Like I did for idle time in the >497 days uptime patch? Then I'll include 
a chunk for user, nice, and system time in the next version and we can see
if Linus takes it.

Tim

