Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261411AbVACJfu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbVACJfu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 04:35:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261412AbVACJfu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 04:35:50 -0500
Received: from frankvm.xs4all.nl ([80.126.170.174]:916 "EHLO janus.localdomain")
	by vger.kernel.org with ESMTP id S261411AbVACJfq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 04:35:46 -0500
Date: Mon, 3 Jan 2005 10:35:45 +0100
From: Frank van Maarseveen <frankvm@frankvm.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Pavel Machek <pavel@ucw.cz>, Oliver Neukum <oliver@neukum.org>,
       luto@myrealbox.com, aebr@win.tue.nl, linux-kernel@vger.kernel.org
Subject: Re: the umount() saga for regular linux desktop users
Message-ID: <20050103093545.GA8524@janus>
References: <20050102193724.GA18136@elf.ucw.cz> <20050102201147.GB4183@stusta.de> <200501022134.16338.oliver@neukum.org> <20050102205151.GE4183@stusta.de> <20050102205650.GG18136@elf.ucw.cz> <20050102210536.GF4183@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050102210536.GF4183@stusta.de>
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 02, 2005 at 10:05:36PM +0100, Adrian Bunk wrote:
> On Sun, Jan 02, 2005 at 09:56:50PM +0100, Pavel Machek wrote:
> > 
> > Okay, so the right solution is probably something more like
> > 
> > while umount /mnt; do
> > 	fuser -km -TERM /mnt
> > 	sleep 1
> > 	fuser -km /mnt
> > done
> 
> A command line user only needs to know about fuser, and in the unlikely 
> case if the race condition Oliver thought of occurs he'll note since 
> umount will give an error message.

There's a much more interesting race: another process succesfully umounting
the thing while this one's asleep.

-- 
Frank
