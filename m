Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267520AbRHJMoM>; Fri, 10 Aug 2001 08:44:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267643AbRHJMoC>; Fri, 10 Aug 2001 08:44:02 -0400
Received: from chaos.analogic.com ([204.178.40.224]:37504 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S267520AbRHJMn6>; Fri, 10 Aug 2001 08:43:58 -0400
Date: Fri, 10 Aug 2001 08:43:58 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Writes to mounted devices containing file-systems.
Message-ID: <Pine.LNX.3.95.1010810075750.10479A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Is it possible that Linux could decline to write to a device that
contains mounted file-systems? OTW, don't allow raw writes to
devices or partitions if they are mounted; writes could only
be through the file-systems themselves.

One of my file-servers was destroyed by an in-house hacker,
(consultant) rented by our alleged Chief Information Officer,
to destroy Linux systems and thereby show that they can't
be used in a "professional" environment.

I have about 20 megabytes of logs showing the machine being
attacked from inside our firewall. Each time an attack occurred,
I would firewall-out its phony IP address (ipchains). A few hours
later the cycle repeated with another phony IP address.

The exploit used multiple calls to get the system time, followed
by an attempt to mount a file-system. Apparently the exploit
eventually works because the system went down and the result was
that the root file-system device, /dev/sda, was completely written
with:

	"S E C U R I T Y "

8 Gb written with this 16-bytes pattern.

This server is very important to my work and it took a long time
to get it back up. The attacks continue. Today they are using some
sendmail exploit:


Aug 10 07:56:02 quark sendmail[66]: rejecting connections on daemon MTA:
load average: 115
Aug 10 07:56:02 quark sendmail[66]: rejecting connections on daemon MSA: load average: 115
Aug 10 07:56:17 quark sendmail[66]: rejecting connections on daemon MTA: load average: 115
Aug 10 07:56:17 quark sendmail[66]: rejecting connections on daemon MSA: load average: 115
Aug 10 07:56:32 quark sendmail[66]: rejecting connections on daemon MTA: load average: 105
Aug 10 07:56:32 quark sendmail[66]: rejecting connections on daemon MSA: load average: 105
Aug 10 07:56:47 quark sendmail[66]: rejecting connections on daemon MTA: load average: 87
Aug 10 07:56:47 quark sendmail[66]: rejecting connections on daemon MSA: load average: 87
Aug 10 07:57:02 quark sendmail[66]: rejecting connections on daemon MTA: load average: 68
Aug 10 07:57:02 quark sendmail[66]: rejecting connections on daemon MSA: load average: 68
Aug 10 07:57:17 quark sendmail[66]: rejecting connections on daemon MTA: load average: 53
Aug 10 07:57:17 quark sendmail[66]: rejecting connections on daemon MSA: load average: 53
Aug 10 07:57:32 quark sendmail[66]: rejecting connections on daemon MTA: load average: 41
Aug 10 07:57:32 quark sendmail[66]: rejecting connections on daemon MSA: load average: 41
Aug 10 07:57:47 quark sendmail[66]: rejecting connections on daemon MTA: load average: 32
Aug 10 07:57:47 quark sendmail[66]: rejecting connections on daemon MSA: load average: 32
Aug 10 07:58:02 quark sendmail[66]: rejecting connections on daemon MTA: load average: 25
Aug 10 07:58:02 quark sendmail[66]: rejecting connections on daemon MSA: load average: 25
Aug 10 07:58:17 quark sendmail[66]: rejecting connections on daemon MTA: load average: 19
Aug 10 07:58:17 quark sendmail[66]: rejecting connections on daemon MSA: load average: 19
Aug 10 07:58:32 quark sendmail[66]: rejecting connections on daemon MTA: load average: 15
Aug 10 07:58:32 quark sendmail[66]: rejecting connections on daemon MSA: load average: 15
Aug 10 07:58:47 quark sendmail[66]: rejecting connections on daemon MTA: load average: 12
Aug 10 07:58:47 quark sendmail[66]: rejecting connections on daemon MSA: load average: 12
Aug 10 07:59:02 quark sendmail[66]: accepting connections again for daemon MTA
Aug 10 07:59:02 quark sendmail[66]: accepting connections again for daemon MSA
Aug 10 08:00:29 quark syslog: callit: (150001) cannot fork: Try again
Aug 10 08:01:03 quark sendmail[66]: rejecting connections on daemon MTA: load average: 239
Aug 10 08:01:03 quark sendmail[66]: rejecting connections on daemon MSA: load average: 239
Aug 10 08:01:18 quark sendmail[66]: rejecting connections on daemon MTA: load average: 267
Aug 10 08:01:18 quark sendmail[66]: rejecting connections on daemon MSA: load average: 267
Aug 10 08:01:33 quark sendmail[66]: rejecting connections on daemon MTA: load average: 278
Aug 10 08:01:33 quark sendmail[66]: rejecting connections on daemon MSA: load average: 278
Aug 10 08:01:48 quark sendmail[66]: rejecting connections on daemon MTA: load average: 276
Aug 10 08:01:48 quark sendmail[66]: rejecting connections on daemon MSA: load average: 276
Aug 10 08:02:03 quark sendmail[66]: rejecting connections on daemon MTA: load average: 264
Aug 10 08:02:03 quark sendmail[66]: rejecting connections on daemon MSA: load average: 264
Aug 10 08:02:18 quark sendmail[66]: rejecting connections on daemon MTA: load average: 245
Aug 10 08:02:18 quark sendmail[66]: rejecting connections on daemon MSA: load average: 245
Aug 10 08:02:33 quark sendmail[66]: rejecting connections on daemon MTA: load average: 219
Aug 10 08:02:33 quark sendmail[66]: rejecting connections on daemon MSA: load average: 219
Aug 10 08:02:48 quark sendmail[66]: rejecting connections on daemon MTA: load average: 187
Aug 10 08:02:48 quark sendmail[66]: rejecting connections on daemon MSA: load average: 187
Aug 10 08:03:03 quark sendmail[66]: rejecting connections on daemon MTA: load average: 153
Aug 10 08:03:03 quark sendmail[66]: rejecting connections on daemon MSA: load average: 153
Aug 10 08:03:18 quark sendmail[66]: rejecting connections on daemon MTA: load average: 119
Aug 10 08:03:18 quark sendmail[66]: rejecting connections on daemon MSA: load average: 119
Aug 10 08:03:24 quark in.rlogind[13609]: connect from chaos.analogic.com
Aug 10 08:03:33 quark sendmail[66]: rejecting connections on daemon MTA: load average: 93
Aug 10 08:03:33 quark sendmail[66]: rejecting connections on daemon MSA: load average: 93
Aug 10 08:03:40 quark su: johnson on /dev/ttyp0
Aug 10 08:03:48 quark sendmail[66]: rejecting connections on daemon MTA: load average: 72
Aug 10 08:03:48 quark sendmail[66]: rejecting connections on daemon MSA: load average: 72
Aug 10 08:04:03 quark sendmail[66]: rejecting connections on daemon MTA: load average: 56
Aug 10 08:04:03 quark sendmail[66]: rejecting connections on daemon MSA: load average: 56
Aug 10 08:04:18 quark sendmail[66]: rejecting connections on daemon MTA: load average: 44
Aug 10 08:04:18 quark sendmail[66]: rejecting connections on daemon MSA: load average: 44
Aug 10 08:04:33 quark sendmail[66]: rejecting connections on daemon MTA: load average: 34
Aug 10 08:04:33 quark sendmail[66]: rejecting connections on daemon MSA: load average: 34
Aug 10 08:04:48 quark sendmail[66]: rejecting connections on daemon MTA: load average: 27
Aug 10 08:04:48 quark sendmail[66]: rejecting connections on daemon MSA: load average: 27
Aug 10 08:05:03 quark sendmail[66]: rejecting connections on daemon MTA: load average: 21
Aug 10 08:05:03 quark sendmail[66]: rejecting connections on daemon MSA: load average: 21
Aug 10 08:05:18 quark sendmail[66]: rejecting connections on daemon MTA: load average: 16
Aug 10 08:05:18 quark sendmail[66]: rejecting connections on daemon MSA: load average: 16
Aug 10 08:05:33 quark sendmail[66]: rejecting connections on daemon MTA: load average: 13
Aug 10 08:05:33 quark sendmail[66]: rejecting connections on daemon MSA: load average: 13
Aug 10 08:05:48 quark sendmail[66]: accepting connections again for daemon MTA
Aug 10 08:05:48 quark sendmail[66]: accepting connections again for daemon MSA


Microsoft FUD has convinced a lot of companies that they will
be subjected to stockholder lawsuits and customer rejection if
they use Linux or any of those "insecure" Unix-type machines.

In this company, they hired a "CIO" who thinks that no computers
should have any local storage or boot capability. They must all
boot from some secure (M$) file-server. They will not be allowed
to have local disks and, horrors -- of course no floppy drives or
CD-ROMS.

He doesn't care that we are in the business of making software-driven
machines so we require access to the guts of computers and their
operating systems.

Linux development needs to know about the "big lie" method of
forcing everybody to use what big companies (or the government)
want you to use. Think, for a minute, about what "everybody knows".

"Everybody knows" relates to something that is so commonly accepted
that nobody bothers to check if it's true or not.

Everybody knows:
	"global warming..."
	"greenhouse gasses..."
	"asbestos as a carcinogin..."
	"etc..."

The next one will be:

	"Linux is insecure..."

So, if it is at all possible to help improve its security without
hurting its performance very much, it's really a matter of life-or-
death for Linux. Otherwise "they" will get us.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


