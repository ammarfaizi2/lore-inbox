Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422707AbWKEVtf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422707AbWKEVtf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 16:49:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422679AbWKEVtf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 16:49:35 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:41690 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1422707AbWKEVte (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 16:49:34 -0500
Date: Sun, 5 Nov 2006 22:49:03 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: Albert Cahalan <acahalan@gmail.com>, kangur@polcom.net,
       linux-kernel@vger.kernel.org
Subject: Re: New filesystem for Linux
Message-ID: <20061105214903.GC1847@elf.ucw.cz>
References: <787b0d920611041159y6171ec25u92716777ce9bea4a@mail.gmail.com> <Pine.LNX.4.64.0611050034480.26021@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611050034480.26021@artax.karlin.mff.cuni.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>>As my PhD thesis, I am designing and writing a filesystem,
> >>>and it's now in a state that it can be released. You can
> >>>download it from http://artax.karlin.mff.cuni.cz/~mikulas/spadfs/
> >>
> >>"Disk that can atomically write one sector (512 bytes) so that
> >>the sector contains either old or new content in case of crash."
> >
> >New drives will soon use 4096-byte sectors. This is a better
> >match for the normal (non-VAX!) page size and reduces overhead.
> 
> The drive (IDE model, SCSI can have larger sector size) will do 
> read-modify-write for smaller writes. So there should be no compatibility 
> issues. (this possibility is in new ATA standard and there is a way how to 

Actually, there are. If you assume powerfail can only destroy 512
bytes... read-modify-write of 4K is going to destroy your "only 512
bytes destroyed" assumption...
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
