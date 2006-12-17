Return-Path: <linux-kernel-owner+w=401wt.eu-S1752531AbWLQMdi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752531AbWLQMdi (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 07:33:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752533AbWLQMdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 07:33:38 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:39961 "EHLO amd.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752531AbWLQMdh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 07:33:37 -0500
Date: Sun, 17 Dec 2006 13:33:29 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Nasty warnings on arm (+ one compile problem -- INIT_WORK related)
Message-ID: <20061217123329.GE28628@elf.ucw.cz>
References: <20061215235818.GD2853@elf.ucw.cz> <20061216010906.GC17561@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061216010906.GC17561@ftp.linux.org.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > (Or will I need to play with container_of or something? I guess I did
> > not pay attetion to workqueue stuff).
> 
> ... and that's
> 
> static void sa1100fb_task(struct work_struct *ucking_fugly)
> {
> 	struct sa1100fb_info *fbi = container_of(ucking_fugly,
> 						 struct sa1100fb_info,
> 						 task);

Thanks, fixed and sent patch to rmk. I made the variable name shorter,
I hope that's okay with you ;-).
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
