Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964853AbVHORTS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964853AbVHORTS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 13:19:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964854AbVHORTS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 13:19:18 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:21408 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S964853AbVHORTR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 13:19:17 -0400
Subject: Re: [rfc][patch] API for timer hooks
From: john stultz <johnstul@us.ibm.com>
To: Stas Sergeev <stsp@aknet.ru>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <42FDF744.2070205@aknet.ru>
References: <42FDF744.2070205@aknet.ru>
Content-Type: text/plain
Date: Mon, 15 Aug 2005 10:19:13 -0700
Message-Id: <1124126354.8630.3.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-08-13 at 17:36 +0400, Stas Sergeev wrote:
> Hello.
> 
> Right now it seems like the only interface
> for registering the timer hooks is that one
> of kernel/profile.c, and it is very limited.
> The arch-specific timer hooks are provided
> in an arch-specific headers as a static
> functions.
> Since my driver needs the timer hook, I
> thought it might be a good idea to add an
> API for registering the timer hooks.
> The attached patch adds such an API and
> converts all the relevant places to use it.
> I changed oprofile to use it, and also
> converted the arch-specific hooks, which
> looks like a fair cleanup.
> 
> The API allows to register, unregister
> and grab the timer hook. The grabbing
> hook will always be executed first, and
> can decide to prevent an execution of
> the rest ones. The hook can have the
> "run_always" flag set, in which case it
> won't be bypassed, regardless of the
> grabbing hook.
> 
> Does such an API look viable?
> As usual, it is needed for the PC-Speaker
> PCM driver that is currently in an ALSA CVS,
> awaiting for the proper interface to appear
> in the kernel.


Interesting. Could you explain why the soft-timer interface doesn't
suffice?

thanks
-john


