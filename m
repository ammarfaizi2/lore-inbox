Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264919AbSLaX3Y>; Tue, 31 Dec 2002 18:29:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264920AbSLaX3Y>; Tue, 31 Dec 2002 18:29:24 -0500
Received: from pdbn-d9bb86aa.pool.mediaWays.net ([217.187.134.170]:7949 "EHLO
	citd.de") by vger.kernel.org with ESMTP id <S264919AbSLaX3X>;
	Tue, 31 Dec 2002 18:29:23 -0500
Date: Wed, 1 Jan 2003 00:37:41 +0100
From: Matthias Schniedermeyer <ms@citd.de>
To: Josh Brooks <user@mail.econolodgetulsa.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Usermode NFS - still in existence ?
Message-ID: <20021231233741.GA25889@citd.de>
References: <20021231141201.D88624-100000@mail.econolodgetulsa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021231141201.D88624-100000@mail.econolodgetulsa.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 31, 2002 at 02:13:58PM -0800, Josh Brooks wrote:
> 
> Hello,
> 
> I have a system running a vendor supplied kernel that I do not have the
> ability to change.  Further, it is modified enough that normal modules
> will not load into it - and of course I cannot compile modules to work
> with it since I don't have the source to the kernel.
> 
> And for some reason they did not compile NFS in.
> 
> And I need this system to be an NFS _client_.
> 
> What are my options ?  I see that at some point there was a usermode NFS
> ... does this still exist ? Is there some other way of mounting an NFS
> volume from userland - really any solution is fine, I just need to mount
> my nfs volume from this server.

Hmmm.

uname -r tells you the base-kernel and what you have to write into
"EXTRAVERSION".
uname -v tells you if you have a SMP or UP-Kernel.

Then you "guess" what CPU-Type was used.
A start-point for this guess is "uname -m".
For a non-specific kernel i would guess i386 (=i386) or Pentium (=i586).
For i686 you can normaly use the CPU from "/proc/cpuinfo".

This way you SHOULD be able to create a module that matches (more or
less) for the kernel you want to load it in.

At least i had luck with this method so far. :-)




Bis denn

-- 
Real Programmers consider "what you see is what you get" to be just as 
bad a concept in Text Editors as it is in women. No, the Real Programmer
wants a "you asked for it, you got it" text editor -- complicated, 
cryptic, powerful, unforgiving, dangerous.

