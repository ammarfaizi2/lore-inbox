Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290109AbSBYSJS>; Mon, 25 Feb 2002 13:09:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292027AbSBYSJI>; Mon, 25 Feb 2002 13:09:08 -0500
Received: from chaos.analogic.com ([204.178.40.224]:21385 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S290109AbSBYSI4>; Mon, 25 Feb 2002 13:08:56 -0500
Date: Mon, 25 Feb 2002 13:08:23 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Dan Maas <dmaas@dcine.com>
cc: "Rose, Billy" <wrose@loislaw.com>, linux-kernel@vger.kernel.org
Subject: Re: ext3 and undeletion
In-Reply-To: <05cb01c1be1e$c490ba00$1a01a8c0@allyourbase>
Message-ID: <Pine.LNX.3.95.1020225125900.26412A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Feb 2002, Dan Maas wrote:

> > but I don't want a Netware filesystem running on Linux, I
> > want a *native* Linux filesystem (i.e. ext3) that has the
> > ability to queue deleted files should I configure it to.
> 
> Rather than implementing this in the filesystem itself, I'd first try
> writing a libc shim that overrides unlink(). You could copy files to safety,
> or do anything else you want, before they actually get deleted...
> 
> Regards,
> Dan
> 
Yes... unlink() becomes `mv /path/filename /deleted/path/filename`
Simple.  For idiot users, you can just make such an alias for those
who insist in doing `rm *` instead of `rm \*` after they had used
a wild-card as a file-name... It happens:

	`ls *.* >files`
...is typoed to:
	`ls *.>* files`

If somebody then recreates the same file and deletes it again -- tough.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).

        111,111,111 * 111,111,111 = 12,345,678,987,654,321

