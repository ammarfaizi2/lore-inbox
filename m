Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261316AbVEZLnM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261316AbVEZLnM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 07:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261319AbVEZLnM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 07:43:12 -0400
Received: from mail.tmr.com ([64.65.253.246]:11780 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S261316AbVEZLnI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 07:43:08 -0400
Date: Thu, 26 May 2005 07:42:16 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
cc: mrmacman_g4@mac.com, linux-kernel@vger.kernel.org
Subject: Re: OT] Joerg Schilling flames Linux on his Blog
In-Reply-To: <4295A1A5.nail2SW21JHSO@burner>
Message-ID: <Pine.LNX.3.96.1050526065847.25436A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 May 2005, Joerg Schilling wrote:


> Looks like you did not read the mail from me you were replying to.

Let's start a technical discussion with a personal attack...
> 
> The best way to fix a problem is to fix the problem and not to do something 
> else and to change the interface.

When possible, correct.
> 
> The problem was that you could send SCSI commands on R/O fds and fixing the
> problem would have been to forbid sending SCSI commands on R/O fds.

IT DOESN'T WORK THAT WAY. You *can't* disallow sending commands, that's
how you do a read on a SCSI device, by sending commands like "seek" and
"read." What is needed is to limit the commands allowed to be sent, and
pass only known appropriate commands depending on access.

It is true that the first implementation didn't have all the legitimate
commands in the table of allowed commands. But once the idea of doing bad
things to a CD by sending evil commands was well-known, it was important
to have protection in place quickly.

It is true that some developers have been very unhelpful, and replied with
canned "you don't have permission" messages to reports that legitimate
commands aren't in the allowed table.

It is true that the implementation is overly complex, instead of using
only read and write, other things are checked, resulting in some
unexpected behaviour, like blocking programs being setuid.

What is NOT TRUE is that any of this was done just to piss you off. That
was just a fringe benefit to fixing the security issue quickly. AFAIK all
of the commands for burning single session CD/DVD are working as intended.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

