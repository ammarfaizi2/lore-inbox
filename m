Return-Path: <linux-kernel-owner+w=401wt.eu-S1030787AbWLPIkT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030787AbWLPIkT (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 03:40:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030788AbWLPIkS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 03:40:18 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:4854 "EHLO spitz.ucw.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1030787AbWLPIkR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 03:40:17 -0500
Date: Sat, 16 Dec 2006 08:40:08 +0000
From: Pavel Machek <pavel@ucw.cz>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: lots of code could be simplified by using ARRAY_SIZE()
Message-ID: <20061216084007.GC4049@ucw.cz>
References: <Pine.LNX.4.64.0612131450270.5979@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612131450270.5979@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>   there are numerous places throughout the source tree that apparently
> calculate the size of an array using the construct
> "sizeof(fubar)/sizeof(fubar[0])". see for yourself:
> 
>   $ grep -Er "sizeof\((.*)\) ?/ ?sizeof\(\1\[0\]\)" *
> 
> but we already have, from "include/linux/kernel.h":
> 
>   #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))

Hmmm. quite misleading name :-(. ARRAY_LEN would be better.

-- 
Thanks for all the (sleeping) penguins.
