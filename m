Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310470AbSCLHNa>; Tue, 12 Mar 2002 02:13:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310468AbSCLHNU>; Tue, 12 Mar 2002 02:13:20 -0500
Received: from codepoet.org ([166.70.14.212]:55471 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S310464AbSCLHNQ>;
	Tue, 12 Mar 2002 02:13:16 -0500
Date: Tue, 12 Mar 2002 00:13:18 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Jeff Garzik <jgarzik@mandrakesoft.com>, Bill Davidsen <davidsen@tmr.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] My AMD IDE driver, v2.7
Message-ID: <20020312071318.GA20921@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	Bill Davidsen <davidsen@tmr.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.96.1020311185647.27404G-100000@gatekeeper.tmr.com> <3C8D4D12.90606@mandrakesoft.com> <20020312005840.GA13955@codepoet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020312005840.GA13955@codepoet.org>
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux 2.4.18-rmk1, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Mar 11, 2002 at 05:58:41PM -0700, Erik wrote:
> I have no argument with basic command validation.  But take a
> look at ide_cmd_type_parser(), for example.  Do we really need a
> giant switch statement listing all the allowed commands, just so
> we can throw back a IDE_DRIVE_TASK_INVALID to user-space if they

In looking closer at the ide driver, it turns out that
ide_cmd_type_parser() is _not_ filtering HDIO_DRIVE_TASKFILE
ioctl commands at all.  My mistake.  There is actually no
filtering at all HDIO_DRIVE_TASKFILE ioctl. 

Strangely enough, ide_cmd_type_parser() is filtering commands
issued by the ide driver itself.

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
