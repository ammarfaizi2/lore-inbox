Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263219AbVBCWOX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263219AbVBCWOX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 17:14:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263218AbVBCWOX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 17:14:23 -0500
Received: from gprs215-226.eurotel.cz ([160.218.215.226]:16588 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S263584AbVBCV6y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 16:58:54 -0500
Date: Thu, 3 Feb 2005 22:53:05 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Matt Mackall <mpm@selenic.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Christophe Saout <christophe@saout.de>,
       Clemens Fruhwirth <clemens@endorphin.org>, dm-crypt@saout.de
Subject: Re: dm-crypt crypt_status reports key?
Message-ID: <20050203215305.GA1483@elf.ucw.cz>
References: <20050202211916.GJ2493@waste.org> <20050202235002.GD14097@agk.surrey.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050202235002.GD14097@agk.surrey.redhat.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > # dmsetup table /dev/mapper/volume1
> > 0 2000000 crypt aes-plain 0123456789abcdef0123456789abcdef 0 7:0 0
>  
> > Obviously, root can in principle recover this password from the
> > running kernel but it seems silly to make it so easy.
>  
> There seemed little point obfuscating it - someone will only
> write a trivial utility that recovers it.
> 
> The current approach has the advantage of making it
> obvious to you that if you have root access, you have
> access to the password while the encrypted data volumes
> are mounted.
> 
> Consider instead *why* you're worried about the password being
> held in RAM and look for better solutions to *your*
> perceived threats.

Actually, this *is* bad. I bet someone is going to post their secret
key to lkml when debugging...

Or I can see conversation like this:

admin: "My devices work too slowly, is there something wrong with
device mapper?"

Pavel walks to his console, says: "Okay, show me your
/dev/mapper/volume1"

admin does that.

For this to be usefull Pavel'd have to remember the key before admin
realizes what he has done, but..... Or imagine pavel shoulder-surfing
admin trying to debug device mapper.

								Pavel 
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
