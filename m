Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261168AbVGTHwt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbVGTHwt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 03:52:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261202AbVGTHwt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 03:52:49 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:25028 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261168AbVGTHwt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 03:52:49 -0400
Date: Wed, 20 Jul 2005 09:52:40 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Kyle Moffett <mrmacman_g4@mac.com>
cc: linux@horizon.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel guide to space
In-Reply-To: <FD559B50-FB1E-4478-ACF4-70E4DB7A0176@mac.com>
Message-ID: <Pine.LNX.4.61.0507200715290.9066@yvahk01.tjqt.qr>
References: <20050714011208.22598.qmail@science.horizon.com>
 <FD559B50-FB1E-4478-ACF4-70E4DB7A0176@mac.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 3)  If a normal line of code is more than 80 characters, one of the
> following is probably true: you need to break the line up and use temps
> for clarity, or your function is so big that you're tabbing over too
> far.

(Find source files, expand tab chars to their on-screen length, print if 
>= 80, count lines)

~/linux-2.6.12 >
  find . -type f "(" -iname "*.c" -o -iname "*.h" -o -iname "*.S" ")" -print0 |
  xargs -0 perl -pe '1 while s/\t+/" "x(length($&)*8-length($`)%8)/e' | \
  perl -ne 'print if/.{80}/' | \
  wc -l
208420

If the indent was just 4 spc wide, the number of extending
lines is just 131925.


Jan Engelhardt
-- 
