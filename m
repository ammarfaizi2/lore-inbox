Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279423AbRJZVxW>; Fri, 26 Oct 2001 17:53:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279411AbRJZVxC>; Fri, 26 Oct 2001 17:53:02 -0400
Received: from [194.213.32.137] ([194.213.32.137]:1796 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S279337AbRJZVwx>;
	Fri, 26 Oct 2001 17:52:53 -0400
Date: Fri, 26 Oct 2001 23:46:19 +0200
From: Pavel Machek <pavel@suse.cz>
To: torvalds@transmeta.com, kernel list <linux-kernel@vger.kernel.org>
Subject: 2.4.13: infinite loop in mm/vmscan.c: shrink_cache()
Message-ID: <20011026234618.A1638@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

shrink_cache() has no error exit; this is obviously problem, because
it loops until it frees enough memory, and there obviously is not
infinite ammount of memory in the system.
								Pavel
-- 
STOP THE WAR! Someone killed innocent Americans. That does not give
U.S. right to kill people in Afganistan.


