Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264523AbTEJXEV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 19:04:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264524AbTEJXEV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 19:04:21 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:29330
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S264523AbTEJXEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 19:04:20 -0400
Subject: Re: logs full of chatty IDE cdrom
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030510224734.GF662@gallifrey>
References: <20030510201744.GD662@gallifrey>
	 <1052599284.19351.2.camel@dhcp22.swansea.linux.org.uk>
	 <20030510224734.GF662@gallifrey>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052605114.19350.9.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 10 May 2003 23:18:36 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2003-05-10 at 23:47, Dr. David Alan Gilbert wrote:
> * Alan Cox (alan@lxorguk.ukuu.org.uk) wrote:
> > On Sad, 2003-05-10 at 21:17, Dr. David Alan Gilbert wrote:
>      ^^^
> Are you running with a Welsh locale there?

Ydw.

> May 10 23:37:32 gallifrey kernel: ATAPI device hde:
> May 10 23:37:32 gallifrey kernel:   Error: Illegal request -- (Sense
> key=0x05)
> May 10 23:37:32 gallifrey kernel:   Parameter list length error --
> (asc=0x1a, ascq=0x00)
> May 10 23:37:32 gallifrey kernel:   The failed "Mode Select 10" packet
> command was:
> May 10 23:37:32 gallifrey kernel:   "55 10 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 "
> May 10 23:37:33 gallifrey kernel: end_request: I/O error, dev hde, sector 0
> May 10 23:38:04 gallifrey last message repeated 31 times

That is interesting. Someone sent a SCSI command the it really didn't
like. This isn't a dell 8100 or similar laptop is it btw ?


> That is with no disc in the drive; the drive identifies itself as:
> 'Pioneer DVD-ROM ATAPIModel DVD-116 0109' 

> and other things rattling the CD drive on older kernels.  In general I
> think I'd just like to tell IDE to be quiet about certain drives so it
> makes it easier to spot serious errors in the logs.

I guess people with raw drive access should learn to program as well. You
could play with drive->quiet I guess (I think its drive->quiet) but right
now the IDE layer has no notion of how severe an error is although it has
some idea who caused it. For 2.5.x passing quiet/loud in the taskfile is
a viable extension for 2.4 its not so clear how you would do it nicely.

