Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266262AbUG0HIW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266262AbUG0HIW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 03:08:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266291AbUG0HIW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 03:08:22 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:59838 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S266262AbUG0HIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 03:08:17 -0400
Date: Tue, 27 Jul 2004 00:08:16 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
Cc: Robert Love <rml@ximian.com>, Andrew Morton <akpm@osdl.org>, cw@f00f.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] kernel events layer
Message-ID: <20040727070816.GA17571@plexity.net>
Reply-To: dsaxena@plexity.net
References: <F989B1573A3A644BAB3920FBECA4D25A6EBFB9@orsmsx407>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F989B1573A3A644BAB3920FBECA4D25A6EBFB9@orsmsx407>
Organization: Plexity Networks
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 26 2004, at 15:58, Perez-Gonzalez, Inaky was caught saying:
> Agreed -- I guess what I am looking for is a regular way to link the 
> instance of the object (if any) that caused the message, so it is easier 
> to take action.
> 
> For a silly example, IDE, I want to know which hard drive had a read 
> error; knowing that it came from drivers/ide/ide-disk.c is useful, but
> quite limited; it doesn't tell me which drive I need to babysit and 
> maybe swap. Certainly the message can print that information as part of
> the text, but chances up we'll end up with something like printk again
> if following that path.

I think that is what the ancillary data field is for atm. Looking
at Robert's original post, he is using "arch/kernel/cpu" as the
object name and stuffing "CPU 0" in the ancillary data.  I think
everyone's agreed that this is not the way to do it, so let's see
what Greg and Robert come up with.

/me goes back to hidding in embedded land

~Deepak

-- 
Deepak Saxena - dsaxena at plexity dot net - http://www.plexity.net/

"Unlike me, many of you have accepted the situation of your imprisonment and
 will die here like rotten cabbages." - Number 6
