Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261910AbTDFNfP (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 09:35:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262961AbTDFNfP (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 09:35:15 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64436 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261910AbTDFNfO (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 09:35:14 -0400
Date: Sun, 6 Apr 2003 14:46:47 +0100
From: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
To: Michael Buesch <freesoftwaredeveloper@web.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Serial port over TCP/IP
Message-ID: <20030406134647.GK639@gallifrey>
References: <200304061447.46393.freesoftwaredeveloper@web.de> <20030406131132.GJ639@gallifrey> <200304061539.00494.freesoftwaredeveloper@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304061539.00494.freesoftwaredeveloper@web.de>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/2.5.66 (i686)
X-Uptime: 14:40:19 up 1 day,  2:03,  1 user,  load average: 0.02, 0.06, 0.09
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Michael Buesch (freesoftwaredeveloper@web.de) wrote:
> On Sunday 06 April 2003 15:11, Dr. David Alan Gilbert wrote:
> > I keep thinking that it would be nice to have a mechanism for user space
> > char devices; it would have to have a mechanism to pass all the ioctls
> > to the process that dealt with it.
> 
> But wouldn't this make too much overhead, if implemented all in userspace?
> I say this, because nbd is also implemented in user- und kernel-space.

Sure it would have overhead; but it would be a general mechanism and
mean that the kernel didn't need lots of char drivers (except for boot
time things). Lots of devices are really just filters/wrappers over
other more basic devices (look at the growing pile of USB serial
device drivers).  Most char devices have such a low throughput that the
little overhead wouldn't make much difference, but would simplify the
kernel.

Dave
 ---------------- Have a happy GNU millennium! ----------------------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM,SPARC,PPC & HPPA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
