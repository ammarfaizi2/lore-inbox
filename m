Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277509AbRKDCUB>; Sat, 3 Nov 2001 21:20:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277493AbRKDCTt>; Sat, 3 Nov 2001 21:19:49 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:64018 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S277533AbRKDCTc>;
	Sat, 3 Nov 2001 21:19:32 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200111040219.fA42JUi129573@saturn.cs.uml.edu>
Subject: Re: pre6 weird ps output
To: jgarzik@mandrakesoft.com (Jeff Garzik)
Date: Sat, 3 Nov 2001 21:19:30 -0500 (EST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <3BDFFB64.CE5F73D9@mandrakesoft.com> from "Jeff Garzik" at Oct 31, 2001 08:23:48 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik writes:
> Jeff Garzik wrote:
>> [jgarzik@brutus rpm]$ ps xf
>>   PID TTY      STAT   TIME COMMAND
>> 16013 pts/1    S      0:00 -bash
>> 32105 pts/1    R      0:00 ps xf
>> 15858 pts/0    S      0:00 -bash
>> 15889 pts/0    S      0:02 /bin/sh /usr/bin/rpm-rebuilder
>> 30660 /tmp/rpm/other_clisp-2.27-1mdk.src.rpm.log S   0:00  \_
>> /usr/lib/rpm/rpmb

Your TTY is /tmp/rpm/other_clisp-2.27-1mdk.src.rpm.log isn't it?
(it is a char device that matches what /proc/*/stat reports)

> Further clue:  kill ssh session and log back in later, and ps output
> [from a different pty] is normal.

This may be because ps from a different pty is unable to see
the real pathname in /proc/*/fd/ and must guess via other means.

The whole name resolution process is really gross. It would be
wonderful to have a /proc/*/tty symlink to examine.

