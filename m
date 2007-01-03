Return-Path: <linux-kernel-owner+w=401wt.eu-S932159AbXACWah@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159AbXACWah (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 17:30:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932161AbXACWah
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 17:30:37 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:52165 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932159AbXACWag (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 17:30:36 -0500
Date: Wed, 3 Jan 2007 23:30:24 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: Frank van Maarseveen <frankvm@frankvm.com>,
       Jan Harkes <jaharkes@cs.cmu.edu>,
       Arjan van de Ven <arjan@infradead.org>,
       Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: Finding hardlinks
Message-ID: <20070103223024.GA5078@elf.ucw.cz>
References: <1166869106.3281.587.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0612231458060.5182@artax.karlin.mff.cuni.cz> <20061229100223.GF3955@ucw.cz> <Pine.LNX.4.64.0701012333380.5162@artax.karlin.mff.cuni.cz> <20070101235320.GS8104@delft.aura.cs.cmu.edu> <Pine.LNX.4.64.0701020055580.32128@artax.karlin.mff.cuni.cz> <20070103185815.GA2182@janus> <Pine.LNX.4.64.0701032009140.6871@artax.karlin.mff.cuni.cz> <20070103192616.GA3299@janus> <Pine.LNX.4.64.0701032027330.6871@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701032027330.6871@artax.karlin.mff.cuni.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >Sure it is. Numerous popular POSIX filesystems do that. There is a lot of
> >inode number space in 64 bit (of course it is a matter of time for it to
> >jump to 128 bit and more)
> 
> If the filesystem was designed by someone not from Unix world (FAT, SMB, 
> ...), then not. And users still want to access these filesystems.
> 
> 64-bit inode numbers space is not yet implemented on Linux --- the problem 
> is that if you return ino >= 2^32, programs compiled without 
> -D_FILE_OFFSET_BITS=64 will fail with stat() returning -EOVERFLOW --- this 
> failure is specified in POSIX, but not very useful.

Hehe, can we simply -EOVERFLOW on VFAT all the time? ...probably not
useful :-(. But ability to say "unknown" in st_ino field would
help....

								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
