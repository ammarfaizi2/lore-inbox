Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290796AbSBOUp4>; Fri, 15 Feb 2002 15:45:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290797AbSBOUpo>; Fri, 15 Feb 2002 15:45:44 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:27921 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S290796AbSBOUpc>; Fri, 15 Feb 2002 15:45:32 -0500
Date: Fri, 15 Feb 2002 21:45:10 +0100
From: Pavel Machek <pavel@suse.cz>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Jens Axboe <axboe@suse.de>,
        kernel list <linux-kernel@vger.kernel.org>, torvalds@transmeta.com
Subject: Re: IDE cleanup for 2.5.4-pre3
Message-ID: <20020215204510.GD5019@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20020208231346.GA1209@elf.ucw.cz> <20020211094230.E1957@suse.de> <20020211134443.GC20854@atrey.karlin.mff.cuni.cz> <20020211181013.K729@suse.de> <20020213225326.A10409@suse.cz> <20020214094046.B37@toy.ucw.cz> <3C6CC19C.3040608@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C6CC19C.3040608@evision-ventures.com>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> It seems bigger as it is at first glance, however if you start to read 
> it at ide.h, the rest should
> be, well,  obivous...

Ouch, its *big*. You should probably start pushing it to Jens ASAP,
because if you'll clean up it a bit more, you'll end with really big
patch which rewrites whole drivers/ide... [Not that it would be a bad
thing.]

My favourite cleanup would be 

struct ide_drive_s {} ide_drive_t;

=>

struct ide_drive {};

and replacing all ide_drive_t with struct ide_drive...

								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
