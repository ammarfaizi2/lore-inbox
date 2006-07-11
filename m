Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751026AbWGKQGl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751026AbWGKQGl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 12:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751116AbWGKQGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 12:06:41 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:22020 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751026AbWGKQGk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 12:06:40 -0400
Date: Tue, 11 Jul 2006 18:06:39 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Cc: David Woodhouse <dwmw2@infradead.org>, torvalds@osdl.org, akpm@osdl.org
Subject: RFC: cleaning up the in-kernel headers
Message-ID: <20060711160639.GY13938@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'd like to cleanup the mess of the in-kernel headers, based on the 
following rules:
- every header should #include everything it uses
- remove unneeded #include's from headers

This would also remove all the implicit rules "before #include'ing 
header foo.h, you must #include header bar.h" you usually only see when 
the compilation fails.

There might be exceptions (e.g. for avoiding circular #include's) but 
these would be special cases.

As a side effect, this might also lead to additional cleanups.

This might cause some breakages, but it should usually only be compile 
breakages I'll fix as soon as I see them (or anyone else reports them 
to me).

My plan is to create a git tree where I'll work on this that will be 
included in -mm.

Is this OK for everyone?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

