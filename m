Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313026AbSDEPdO>; Fri, 5 Apr 2002 10:33:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313020AbSDEPdF>; Fri, 5 Apr 2002 10:33:05 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:53252 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S313016AbSDEPc4>; Fri, 5 Apr 2002 10:32:56 -0500
Date: Fri, 5 Apr 2002 10:29:47 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: =?iso-8859-1?q?willy=20tarreau?= <wtarreau@yahoo.fr>
cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: faster boots?
In-Reply-To: <20020405132132.50285.qmail@web20512.mail.yahoo.com>
Message-ID: <Pine.LNX.3.96.1020405101901.8337A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Apr 2002, [iso-8859-1] willy tarreau wrote:

> > It's normally done with hdparm spindown when idle
> > options...
> 
> only supported on IDE devices.

I didn't have a machine to test, that's not clear from the man page:

       Some  options (eg. -r for SCSI) may not work with old ker-
       nels as necessary ioctl()'s were not supported.

       Although this utility is intended primarily for  use  with
       (E)IDE  hard disk devices, several of the options are also
       valid (and permitted) for use with SCSI hard disk  devices
       and MFM/RLL hard disks with XT interfaces.
and

       -S     Set  the  standby (spindown) timeout for the drive.
              This value is used by the drive  to  determine  how
              long to wait (with no disk activity) before turning
              off the spindle motor to save  power.   Under  such
              circumstances,  the  drive  may  take as long as 30
              seconds to respond to  a  subsequent  disk  access,
              though  most drives are much quicker.  The encoding
              of the timeout value is somewhat peculiar.  A value
              of  zero means "off".  Values from 1 to 240 specify
              multiples of 5 seconds, for timeouts from 5 seconds
              to 20 minutes.  Values from 241 to 251 specify from
              1 to 11 units of 30 minutes, for timeouts  from  30
              minutes  to  5.5 hours.  A value of 252 signifies a
              timeout of 21 minutes, 253  sets  a  vendor-defined
              timeout,  and 255 is interpreted as 21 minutes plus
              15 seconds.

so I thought this might be helpful for someone with the problem to
consider. I'll be building a suitable machine in the next few days, so I
will try it with current hdparm, just for my own edification.

There is a scsi-idle program of some age floating around, I haven't looked
at that but I know it exists. As I recall it used the sg interface, but
that's purely what I remember from the days when a 600MB Maxtor made me a
king. I went through a few years ago and backed them all up to one CD
each...

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

