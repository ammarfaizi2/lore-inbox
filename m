Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263439AbTJQMh5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 08:37:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263451AbTJQMh5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 08:37:57 -0400
Received: from chaos.analogic.com ([204.178.40.224]:59520 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263439AbTJQMhz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 08:37:55 -0400
Date: Fri, 17 Oct 2003 08:38:57 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Albert Cahalan <albert@users.sourceforge.net>
cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: unsafe printk
In-Reply-To: <1066354577.15921.111.camel@cube>
Message-ID: <Pine.LNX.4.53.0310170834160.2962@chaos>
References: <1066354577.15921.111.camel@cube>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Oct 2003, Albert Cahalan wrote:

> Suppose I name an executable this:
> "\n<0>Oops: EIP=0"
>
> That comes out as a KERN_EMERG log message,
> hitting the console and maybe a pager even.
>
> There seem to be a number of places in the
> kernel that printk current->comm without
> concern for what it may contain.
>
> Escape codes and non-ASCII can make for some
> interesting log messages as well. Terminals
> may have some programmable keys or answerback
> messages. So one day root is using grep on
> the log files, and they program the answerback
> string to contain a "\r\nrm -r /\r\n"...
>
> BTW, the 0x9b character is often an escape.

I remember this from VAX/VMS "system manager school"!
"Don't ever read anybody's data from the SYSTEM account...."

The text read could write a whole command-procedure to
the answer-back buffer, then tell it to answer-back! The
result would be the execution of anything from a privileged
account.

I don't think the built-in VT100-220 emulation has an
answer-back buffer, but there still are RS-232C terminals
out there........


Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


