Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316845AbSHXWcA>; Sat, 24 Aug 2002 18:32:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316853AbSHXWcA>; Sat, 24 Aug 2002 18:32:00 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61189 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316845AbSHXWb7>;
	Sat, 24 Aug 2002 18:31:59 -0400
Date: Sat, 24 Aug 2002 23:36:09 +0100
From: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk,
       mec@shout.net
Subject: Re: Of hanging menuconfig [cause found]
Message-ID: <20020824223609.GE735@gallifrey>
References: <20020824151329.GB735@gallifrey> <20020824225858.A1487@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020824225858.A1487@mars.ravnborg.org>
User-Agent: Mutt/1.4i
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/2.4.18 (i686)
X-Uptime: 23:33:54 up 1 day,  3:25,  1 user,  load average: 2.01, 2.03, 2.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Sam Ravnborg (sam@ravnborg.org) wrote:
> On Sat, Aug 24, 2002 at 04:13:29PM +0100, I wrote:

 <in short, menuconfig hangs if lxdialog is built for wrong
 architecture>

> This does not make sense...
> lxdialog are compiled utilising HOSTCC, and HOSTCC always points to gcc.
> So unless you fail to keep gcc for native in PATH and use:
> $> make CROSS_COMPILE=arm all
> to do cross-compile the above scenario should not be possible.

No, much simpler scenario; your kernel source is on an NFS partition.
You cross compile it; many days later you compile the same code natively
on the target from the same directory (for example if you suspect
instability is caused by cross compilation).

Dave
 ---------------- Have a happy GNU millennium! ----------------------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM, SPARC and HP-PA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
