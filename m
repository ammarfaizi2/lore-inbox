Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266970AbRGMIqp>; Fri, 13 Jul 2001 04:46:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266971AbRGMIqf>; Fri, 13 Jul 2001 04:46:35 -0400
Received: from alb-66-24-215-176.nycap.rr.com ([66.24.215.176]:19726 "EHLO
	swamijr.dyndns.org") by vger.kernel.org with ESMTP
	id <S266970AbRGMIqX>; Fri, 13 Jul 2001 04:46:23 -0400
Message-ID: <XFMail.010713044617.n2por@amsat.org>
X-Mailer: XFMail 1.3 [p0] on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <200107122226.f6CMQVU64270@aslan.scsiguy.com>
Date: Fri, 13 Jul 2001 04:46:17 -0400 (EDT)
From: Chuck Hemker <n2por@amsat.org>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Subject: Re: Adaptec SCSI driver lockups
Cc: linux-kernel@vger.kernel.org, Luc Lalonde <llalonde@giref.ulaval.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 12-Jul-01 Justin T. Gibbs wrote:
>>Hello Justin and Alan,
>>
>>There was some garbage printed to the /var/log/messages before the
>>lockup but it is unreadable.
> 
> It may have been corrupted by the hang/crash.  This is why using
> a serial console is *always* the best bet for tracking down these
> kinds of issues.
> 
>>If I use the append="aic7xxx=verbose"
>>in my lilo.conf will it log extra messages in /var/log/messages?
> 
> The messages are printed to the console and, if syslogd is running,
> will be recorded in /var/log/messages.  However, there is always
> a delay between the error being printed and syslogd getting that
> text to disk.  A serial console doesn't have this problem.
> 
>>If so,
>>will it be useful enough to figure out what the problem is?
> 
> I'll let you know when I see the messages. ;-)
> 
> --
> Justin

If the message looks like it's getting as far as the messages file, but getting
corrupt by the lockup, what about configuring syslog to send the messages over
the net to another machine.  Maybe it will get the UDP packet out before the
lockup.  Also, this could be done without rebooting the machine.  Might be
worth a try first.


