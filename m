Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268865AbUHLX1q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268865AbUHLX1q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 19:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268880AbUHLXZs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 19:25:48 -0400
Received: from gprs214-76.eurotel.cz ([160.218.214.76]:14728 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S268865AbUHLXW7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 19:22:59 -0400
Date: Fri, 13 Aug 2004 01:22:42 +0200
From: Pavel Machek <pavel@suse.cz>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: is_head_of_free_region slowing down swsusp
Message-ID: <20040812232242.GI15138@elf.ucw.cz>
References: <20040812222348.GA10791@elf.ucw.cz> <1092350569.24776.22.camel@laptop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092350569.24776.22.camel@laptop.cunninghams>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > is_head_of_free_region with count_and_copy_zone results results in
> > pretty nasty O(number_of_free_regions^2) behaviour, and some users see
> > cpu spending 40 seconds there :-(.
> > 
> > Actually count_and_copy_zone would probably be happy with
> > "is_free_page()".
> 
> Take a look at my implementation. I do a one-time pass through the slow
> path, building a bitmap of free pages. is_head_of_free_region is then
> simply a O(1) loop through the bitmap.

I've seen that solution (thanks)... I'd like to do something simpler.

									Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
