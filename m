Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270760AbTG0LfV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 07:35:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270762AbTG0LfU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 07:35:20 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:19351
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S270760AbTG0LfM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 07:35:12 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Ingo Molnar <mingo@elte.hu>, Willy Tarreau <willy@w.ods.org>
Subject: Re: Ingo Molnar and Con Kolivas 2.6 scheduler patches
Date: Sun, 27 Jul 2003 21:54:31 +1000
User-Agent: KMail/1.5.2
Cc: Andrew Morton <akpm@osdl.org>, Daniel Phillips <phillips@arcor.de>,
       <ed.sweetman@wmich.edu>, <eugene.teo@eugeneteo.net>,
       <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0307271110140.7393-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0307271110140.7393-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307272154.31689.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Jul 2003 19:12, Ingo Molnar wrote:
> On Sun, 27 Jul 2003, Willy Tarreau wrote:
> > just a thought : have you tried to set the timer to 100Hz instead of
> > 1kHz to compare with 2.4 ? It might make a difference too.
>
> especially for X, a HZ of 1000 has caused performance problems before -
> short-timeout select()s were looping 10 times faster, which can be
> noticeable.

No doubt X was a bit smoother at 100Hz in 2.5, but not remarkably so. In 2.4 
O(1) there was a slight X flutter (jerkiness) at 1000Hz not evident at 100Hz, 
but very consistent in the frequency/duration of that jerkiness. The 
difference is in 2.5, when X is not smooth it's almost like there's jitter in 
the jerkiness.

Con

