Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310254AbSCLA7C>; Mon, 11 Mar 2002 19:59:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310257AbSCLA6w>; Mon, 11 Mar 2002 19:58:52 -0500
Received: from codepoet.org ([166.70.14.212]:1958 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S310254AbSCLA6k>;
	Mon, 11 Mar 2002 19:58:40 -0500
Date: Mon, 11 Mar 2002 17:58:41 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Bill Davidsen <davidsen@tmr.com>, Linus Torvalds <torvalds@transmeta.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] My AMD IDE driver, v2.7
Message-ID: <20020312005840.GA13955@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	Bill Davidsen <davidsen@tmr.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.96.1020311185647.27404G-100000@gatekeeper.tmr.com> <3C8D4D12.90606@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C8D4D12.90606@mandrakesoft.com>
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux 2.4.18-rmk1, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Mar 11, 2002 at 07:34:26PM -0500, Jeff Garzik wrote:
> Reason 1: Standard kernel convention.  In other ioctls, we check basic 
> arguments and return EINVAL when they are wrong, even for privieleged 
> ioctls.

I have no argument with basic command validation.  But take a
look at ide_cmd_type_parser(), for example.  Do we really need a
giant switch statement listing all the allowed commands, just so
we can throw back a IDE_DRIVE_TASK_INVALID to user-space if they
decide to send down some undocumeted firmware wiping commands?
Especially since that giant struct of allowed commands is
duplicated in ide_pre_handler_parser() and ide_handler_parser() 

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
