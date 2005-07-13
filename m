Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262800AbVGMWSt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262800AbVGMWSt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 18:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262861AbVGMWOv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 18:14:51 -0400
Received: from mail.kroah.org ([69.55.234.183]:10462 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262864AbVGMWNm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 18:13:42 -0400
Date: Wed, 13 Jul 2005 15:13:11 -0700
From: Greg KH <greg@kroah.com>
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: Greg KH <gregkh@suse.de>, torvalds@osdl.org, akpm@osdl.org,
       "Theodore Ts'o" <tytso@mit.edu>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>, netdev@vger.kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>, linux-kernel@vger.kernel.org,
       ralf@linux-mips.org, "Randy.Dunlap" <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, jgarzik@pobox.com,
       stable@kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: [stable] Re: [05/11] SMP fix for 6pack driver
Message-ID: <20050713221311.GA30039@kroah.com>
References: <20050713184130.GA9330@kroah.com> <20050713184331.GG9330@kroah.com> <20050713220123.GA3292@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050713220123.GA3292@electric-eye.fr.zoreil.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2005 at 12:01:23AM +0200, Francois Romieu wrote:
> Greg KH <gregkh@suse.de> :
> > -stable review patch.  If anyone has any objections, please let us know.
> > 
> > ------------------
> > 
> > 
> > Drivers really only work well in SMP if they actually can be selected.
> > This is a leftover from the time when the 6pack drive only used to be
> > a bitrotten variant of the slip driver.
> 
> Is the guideline above from 28/04/2005 obsoleted ?
> 
>  - It must fix a problem that causes a build error (but not for things
>    marked CONFIG_BROKEN), an oops, a hang, data corruption, a real
>    security issue, or some "oh, that's not good" issue.  In short,
>    something critical.

It lets the driver be built, when it previously could not be, unless the
user used a config option that almost no one does...

That's pretty critical if you ask me.

thanks,

greg k-h
