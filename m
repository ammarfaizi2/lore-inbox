Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932457AbVHSGd4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932457AbVHSGd4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 02:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750955AbVHSGd4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 02:33:56 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:1240 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1750968AbVHSGdz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 02:33:55 -0400
Date: Fri, 19 Aug 2005 08:36:06 +0200
From: Jens Axboe <axboe@suse.de>
To: Pavel Machek <pavel@suse.cz>
Cc: Adam Goode <adam@evdebs.org>,
       Alejandro Bonilla Beeche <abonilla@linuxwireless.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       hdaps devel <hdaps-devel@lists.sourceforge.net>
Subject: Re: HDAPS, Need to park the head for real
Message-ID: <20050819063602.GD6273@suse.de>
References: <1124205914.4855.14.camel@localhost.localdomain> <20050816200708.GE3425@suse.de> <20050818204904.GE516@openzaurus.ucw.cz> <1124399756.28353.0.camel@lynx.auton.cs.cmu.edu> <20050818213823.GA4275@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050818213823.GA4275@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18 2005, Pavel Machek wrote:
> Hi!
> 
> > > Please make it "echo 1 > frozen", then userspace can do "echo 0 > frozen"
> > > after five seconds.
> > 
> > What if the code to do "echo 0 > frozen" is swapped out to disk? ;)
> 
> Emergency head parker needs to be pagelocked for other reasons. You do
> not want to page it from disk while your notebook is in free fall.

It's still a very bad idea imho, what if the head parker daemon is
killed for other reasons? The automatic timeout thawing the drive is
much saner.

-- 
Jens Axboe

