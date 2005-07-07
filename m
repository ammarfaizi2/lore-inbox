Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262195AbVGGTSB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262195AbVGGTSB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 15:18:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262192AbVGGTPd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 15:15:33 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:56986 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262258AbVGGTOl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 15:14:41 -0400
Date: Thu, 7 Jul 2005 21:14:30 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Grzegorz Kulewski <kangur@polcom.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, ast@domdv.de
Subject: Re: [swsusp] encrypt suspend data for easy wiping
Message-ID: <20050707191429.GA1435@elf.ucw.cz>
References: <20050703213519.GA6750@elf.ucw.cz> <20050706020251.2ba175cc.akpm@osdl.org> <20050706091104.GB1301@elf.ucw.cz> <Pine.LNX.4.63.0507061440470.7125@alpha.polcom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0507061440470.7125@alpha.polcom.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>>To prevent data gathering from swap after resume you can encrypt the
> >>>suspend image with a temporary key that is deleted on resume. Note
> >>>that the temporary key is stored unencrypted on disk while the system
> >>>is suspended... still it means that saved data are wiped from disk
> >>>during resume by simply overwritting the key.
> >>
> >>hm, how useful is that?  swap can still contain sensitive userspace
> >>stuff.
> >
> >At least userspace has chance to mark *really* sensitive stuff as
> >unswappable. Unfortunately that does not work against swsusp :-(.
> >
> >[BTW... I was thinking about just generating random key on swapon, and
> >using it, so that data in swap is garbage after reboot; no userspace
> >changes needed. What do you think?]
> 
> I (and many others) are doing it already in userspace. Don't you know 
> about dm-crypt? I think the idea is described in its docs or wiki...

I could not find anything in device-mapper/*; do you have pointer to
docs or wiki?
								Pavel 

-- 
teflon -- maybe it is a trademark, but it should not be.
