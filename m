Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274883AbRIZITN>; Wed, 26 Sep 2001 04:19:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274884AbRIZITD>; Wed, 26 Sep 2001 04:19:03 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:2309 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S274883AbRIZISu>; Wed, 26 Sep 2001 04:18:50 -0400
Date: Wed, 26 Sep 2001 10:19:14 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: swsusp: move resume before mounting root [diff against vanilla 2.4.9]
Message-ID: <20010926101914.A28339@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20010918184227.B10591@bug.ucw.cz> <200109260602.f8Q62TM420328@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200109260602.f8Q62TM420328@saturn.cs.uml.edu>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Solution for the filesystem problems:
> 
> 1. at suspend, basically unmount the filesystem (keep the mount tree)
> 2. at resume, re-validate open files

Wrong solution. ;-).

Solution to filesystem problems: at suspend, sync but don't do
anything more. At resume, don't try to mount anything (so that you
don't replay transactions or damage disk in any other way).
					Pavel



-- 
Causalities in World Trade Center: 6453 dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
