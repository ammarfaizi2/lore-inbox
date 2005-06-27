Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261887AbVF0Hdr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261887AbVF0Hdr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 03:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261893AbVF0Hdr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 03:33:47 -0400
Received: from mx1.elte.hu ([157.181.1.137]:45500 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261887AbVF0Hdm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 03:33:42 -0400
Date: Mon, 27 Jun 2005 09:31:39 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Dave Airlie <airlied@gmail.com>
Cc: Dave Airlie <airlied@linux.ie>, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: SiS drm broken during 2.6.9-rc1-bk1
Message-ID: <20050627073139.GB12776@elte.hu>
References: <Pine.LNX.4.58.0502131124090.16528@skynet> <21d7e99705021400266bcbc0f2@mail.gmail.com> <20050215103207.GA19866@elte.hu> <21d7e997050626160729afdff2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21d7e997050626160729afdff2@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Dave Airlie <airlied@gmail.com> wrote:

> Just for completeness, Thomas Winischoffer tracked this down over the 
> weekend, I had stared at it previously to no great avail,
> 
> The issue was with the user space SiS Mesa driver having an 
> uninitialised structure on the stack for the copy command sent to the 
> DRM, with the old layout it would end up with zero'ed reserved fields 
> by luck most of the time, with the new one it went the other way..

ah, makes sense.

> the fix is now in Mesa CVS....

great!

	Ingo
