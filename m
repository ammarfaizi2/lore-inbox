Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261939AbUJYWRv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261939AbUJYWRv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 18:17:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262040AbUJYWPL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 18:15:11 -0400
Received: from gprs214-185.eurotel.cz ([160.218.214.185]:41089 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261974AbUJYWMw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 18:12:52 -0400
Date: Tue, 26 Oct 2004 00:12:38 +0200
From: Pavel Machek <pavel@suse.cz>
To: Stelian Pop <stelian@popies.net>,
       Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org,
       Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH 0/5] Sonypi driver model & PM changes
Message-ID: <20041025221238.GB5207@elf.ucw.cz>
References: <200410210154.58301.dtor_core@ameritech.net> <20041025125629.GF6027@crusoe.alcove-fr> <20041025135036.GA3161@crusoe.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041025135036.GA3161@crusoe.alcove-fr>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> * allocate a FN key event and let FN be a modifier.
> 
>   This is much nicer (less events allocated in input.h), but I haven't
>   found a way (and I'm not sure there is one) to say to X that Fn is

I think this is *bad* idea. In such case, userland would see
Fn-F3. My notebook has "sleep" key on Fn-F3, but your notebook
probably has something else there. You'd need another mapping in
userspace...

I believe Fn-F3 on my machine is meant to be replacement for hardware
sleep button (and it has sleep label on it!), and we really should
generate sleep event for Fn-F3...
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
