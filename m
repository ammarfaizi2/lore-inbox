Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261403AbSJMCwV>; Sat, 12 Oct 2002 22:52:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261404AbSJMCwV>; Sat, 12 Oct 2002 22:52:21 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:41481 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S261403AbSJMCwU>;
	Sat, 12 Oct 2002 22:52:20 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: How does ide-scsi get loaded? 
In-reply-to: Your message of "12 Oct 2002 12:01:19 -0400."
             <m37kgn3auo.fsf@varsoon.wireboard.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 13 Oct 2002 12:57:59 +1000
Message-ID: <13355.1034477879@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 Oct 2002 12:01:19 -0400, 
Doug McNaught <doug@mcnaught.org> wrote:
>Alan Chandler <alan@chandlerfamily.org.uk> writes:
>
>> so isn't /etc/lilo.conf in /etc.
>> 
>> I keep saying - the string ide-scsi is not used anywhere in /etc
>> 
>> [and believe me, I have also looked manually at all these sorts of places]
>
>Why not wrap /sbin/modprobe in a script that logs the module name to
>the console?

man insmod, see /var/log/ksymoops.  insmod/modprobe not only record the
symbols, they also append to the daily log.

# cat /var/log/ksymoops/20021012.log 
20021012 103139 start modprobe -r 3c589_cs safemode=0
20021012 103139 rmmod returned 0
20021012 103141 start /sbin/modprobe ide-probe-mod safemode=0
20021012 103141 probe ended
20021012 103141 start /sbin/modprobe ide-probe safemode=0
20021012 103141 probe ended
20021012 103141 start /sbin/modprobe -k -C /etc/modules.devfs /dev/fd1 safemode=0
20021012 103141 probe ended
20021012 103141 start /sbin/modprobe -k -C /etc/modules.devfs /dev/fd2 safemode=0
20021012 103141 probe ended
20021012 103141 start /sbin/modprobe -k -C /etc/modules.devfs /dev/fd3 safemode=0
20021012 103141 probe ended

... lots more devfs probes deleted.

