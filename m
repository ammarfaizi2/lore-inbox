Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288010AbSAHNMR>; Tue, 8 Jan 2002 08:12:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288011AbSAHNL4>; Tue, 8 Jan 2002 08:11:56 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:61712 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S288010AbSAHNLs>; Tue, 8 Jan 2002 08:11:48 -0500
Subject: Re: can we make anonymous memory non-EXECUTABLE?
To: davidm@hpl.hp.com
Date: Tue, 8 Jan 2002 13:23:15 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, linux-ia64@linuxia64.org
In-Reply-To: <200201080025.QAA26731@napali.hpl.hp.com> from "David Mosberger" at Jan 07, 2002 04:25:10 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16NwDj-0006LP-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Opinions?
> 
> Quite frankly, my personal preference is "We are the borg of x86" choice,
> especially on ia64. The security issue with stack smashing etc is a
> complete non-issue: if the program allows a buffer overrun it is insecure
> whether EXEC is set or not.

I semi agree with Linus comment. However it is a lot easier to make attacks
_hard_ especially on a 64bit box by having non executable areas. My
personal feeling is that for an existing production world port like Alpha
you fix the sbrk bug so you always get executable memory. For the IA64
its a new platform and you either say "No it isnt executable" or let ld.so
and malloc do the remapping based on environment variable settings.

We are borg of x86 is true for the near future, but codifying an x86ism for
all ports for ever seems unwise.

For IA32 on IA64 binaries you would however need to keep the executable
data behaviour.

Alan
