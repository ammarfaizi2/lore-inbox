Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264520AbTEJWe4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 18:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264521AbTEJWez
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 18:34:55 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:1987 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264520AbTEJWey
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 18:34:54 -0400
Date: Sat, 10 May 2003 23:47:34 +0100
From: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: logs full of chatty IDE cdrom
Message-ID: <20030510224734.GF662@gallifrey>
References: <20030510201744.GD662@gallifrey> <1052599284.19351.2.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1052599284.19351.2.camel@dhcp22.swansea.linux.org.uk>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/2.5.69 (i686)
X-Uptime: 23:38:21 up 11:36,  1 user,  load average: 0.00, 0.00, 0.03
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Alan Cox (alan@lxorguk.ukuu.org.uk) wrote:
> On Sad, 2003-05-10 at 21:17, Dr. David Alan Gilbert wrote:
     ^^^
Are you running with a Welsh locale there?

> > Hi,
> >   I'm not sure but this seems to be a lot worse in 2.5.x for some
> > reason; my logs are full of I/O errors, not ready's and other errors from
> > my CDROM drive that is playing audio CDs; I suspect at least some of it
> > is due to kscd trying to figure out if there is a CD in an empty drive.
> 
> That shouldnt be generating messages. Its more important to know why or
> to see wtf its doing that generates them

OK, the full messages on starting kscd up are:

May 10 23:37:32 gallifrey kernel: end_request: I/O error, dev hde,
sector 0
May 10 23:37:32 gallifrey last message repeated 3 times
May 10 23:37:32 gallifrey kernel: hde: packet command error: status=0x51
{ DriveReady SeekComplete Error }
May 10 23:37:32 gallifrey kernel: hde: packet command error: error=0x50
May 10 23:37:32 gallifrey kernel: end_request: I/O error, dev hde, sector 0
May 10 23:37:32 gallifrey kernel: ATAPI device hde:
May 10 23:37:32 gallifrey kernel:   Error: Illegal request -- (Sense
key=0x05)
May 10 23:37:32 gallifrey kernel:   Parameter list length error --
(asc=0x1a, ascq=0x00)
May 10 23:37:32 gallifrey kernel:   The failed "Mode Select 10" packet
command was:
May 10 23:37:32 gallifrey kernel:   "55 10 00 00 00 00 00 00 00 00 00 00
00 00 00 00 "
May 10 23:37:33 gallifrey kernel: end_request: I/O error, dev hde, sector 0
May 10 23:38:04 gallifrey last message repeated 31 times

That is with no disc in the drive; the drive identifies itself as:
'Pioneer DVD-ROM ATAPIModel DVD-116 0109' and driver is 
'ide-cdrom version 4.59-ac1' (in 2.5.69)

But to be honest, my observation is more general - I'm sure I've seen
similar messages from VMware on systems (this system does not have it)
and other things rattling the CD drive on older kernels.  In general I
think I'd just like to tell IDE to be quiet about certain drives so it
makes it easier to spot serious errors in the logs.

Dave
 ---------------- Have a happy GNU millennium! ----------------------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM,SPARC,PPC & HPPA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
