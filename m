Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422798AbWGJUIB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422798AbWGJUIB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 16:08:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422695AbWGJUIB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 16:08:01 -0400
Received: from post-25.mail.nl.demon.net ([194.159.73.195]:52188 "EHLO
	post-25.mail.nl.demon.net") by vger.kernel.org with ESMTP
	id S1422798AbWGJUIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 16:08:00 -0400
Date: Mon, 10 Jul 2006 22:07:58 +0200
From: Rutger Nijlunsing <rutger@nospam.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, pasky@suse.cz
Subject: Re: git, hardlinks and backups
Message-ID: <20060710200758.GA5346@nospam.com>
Reply-To: linux-kernel@tux.tmfweb.nl
References: <20060710195727.GA2246@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060710195727.GA2246@elf.ucw.cz>
Organization: M38c
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2006 at 09:57:27PM +0200, Pavel Machek wrote:
> Hi!
> 
> I know this may be stupid, but...
> 
> I'm backing up my linux kernel trees, and found out that backup (done
> by rsync) is twice as big as original. That's quite bad... it is
> because git uses hardlinks heavily but rsync can't preserve them.
> 
> I'm pretty sure someone hit this before... what is the trick?
> 								Pavel

Why can't rsync preserve them? Doesn't 'rsync --hard-links' work?
(however, it can only work if you rsync all paths at once so rsync
gets to see that the inodes match)

-- 
Rutger Nijlunsing ---------------------------------- eludias ed dse.nl
never attribute to a conspiracy which can be explained by incompetence
----------------------------------------------------------------------
