Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269067AbUHMKZw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269067AbUHMKZw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 06:25:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269063AbUHMKXG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 06:23:06 -0400
Received: from gprs214-243.eurotel.cz ([160.218.214.243]:41858 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S269059AbUHMKV6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 06:21:58 -0400
Date: Fri, 13 Aug 2004 12:21:41 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: is_head_of_free_region slowing down swsusp
Message-ID: <20040813102141.GA12958@elf.ucw.cz>
References: <20040812222348.GA10791@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040812222348.GA10791@elf.ucw.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> is_head_of_free_region with count_and_copy_zone results results in
> pretty nasty O(number_of_free_regions^2) behaviour, and some users see
> cpu spending 40 seconds there :-(.
> 
> Actually count_and_copy_zone would probably be happy with
> "is_free_page()".
> 
> I asked Lukas (who is seeing this problem) to kill locking from
> is_head_of_free_region [we are running singlethreaded at this point,
> so it should be ok]. Do you have any other ideas?

Thanks to Lukas Horalek for some timing info....

I now reproduced in on my machine. updatedb is enough to trigger
40seconds of copying. Killing locking does not help :-(.

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
