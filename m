Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261177AbVGDO1t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261177AbVGDO1t (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 10:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261173AbVGDO1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 10:27:48 -0400
Received: from web88009.mail.re2.yahoo.com ([206.190.37.196]:51038 "HELO
	web88009.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S261178AbVGDO11 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 10:27:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=rogers.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=uxgcuBA87aoV1f07A+2203A4Je9HtSHpw0YH9tCVBbJTT3FOfBdkXvbvKGPAvVeETwq+26vNfqjaBH+bPo7xwoYKXLUHAIetuRtwBc4MNeZEQ27O2WWYIZEbHCxJtpLgjPblkEAxrhEBu58dPXbt1q9VZ80JuYR4Xf4NkDLwJR4=  ;
Message-ID: <20050704142723.2202.qmail@web88009.mail.re2.yahoo.com>
Date: Mon, 4 Jul 2005 10:27:23 -0400 (EDT)
From: Shawn Starr <shawn.starr@rogers.com>
Subject: Re: IBM HDAPS things are looking up (was: Re: [Hdaps-devel] Re: [ltp] IBM HDAPS Someone interested? (Accelerometer))
To: Jens Axboe <axboe@suse.de>, Lenz Grimmer <lenz@grimmer.com>
Cc: Jesper Juhl <jesper.juhl@gmail.com>,
       Alejandro Bonilla <abonilla@linuxwireless.org>,
       Dave Hansen <dave@sr71.net>, Henrik Brix Andersen <brix@gentoo.org>,
       hdaps-devel@lists.sourceforge.net,
       LKML List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050704061713.GA1444@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We could put it in userspace, but if the system is
swapping like mad, can we still get a critical
response if this remains in userspace fully?

Someone mentioned we should use a kernel thread(s) to
handle stopping all I/O so we can safely park heads.

Shawn.

--- Jens Axboe <axboe@suse.de> wrote:

> On Mon, Jul 04 2005, Lenz Grimmer wrote:
> > > I'll be working on adding sysfs stuff to it
> tomorrow so it's generally
> > > useful (at least for monitoring things - not yet
> for parking disk
> > > heads).
> > 
> > Maybe there is some kind of all-purpose ATA
> command that instructs the
> > disk drive to park the heads? Jens, could you give
> us a hint on how a
> > userspace application would do that?
> 
> Dunno if there's something that explicitly only
> parks the head, the best
> option is probably to issue a STANDBY_NOW command.
> You can test this
> with hdparm -y.
> 
> Generel observation on this driver - why isn't it
> just contained in user
> space? You need to do the monitoring and sending of
> ide commands from
> there anyways, I don't see the point of putting it
> in the kernel.
> 
> -- 
> Jens Axboe
> 
> 
> 
>
-------------------------------------------------------
> SF.Net email is sponsored by: Discover Easy Linux
> Migration Strategies
> from IBM. Find simple to follow Roadmaps,
> straightforward articles,
> informative Webcasts and more! Get everything you
> need to get up to
> speed, fast.
>
http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
> _______________________________________________
> Hdaps-devel mailing list
> Hdaps-devel@lists.sourceforge.net
>
https://lists.sourceforge.net/lists/listinfo/hdaps-devel
> 

