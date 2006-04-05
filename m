Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750780AbWDENqy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780AbWDENqy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 09:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751151AbWDENqy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 09:46:54 -0400
Received: from smtp2.home.se ([212.78.199.22]:56453 "EHLO smtp2.home.se")
	by vger.kernel.org with ESMTP id S1750780AbWDENqy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 09:46:54 -0400
Date: Wed, 5 Apr 2006 15:44:45 +0200
From: Martin Samuelsson <sam@home.se>
To: Andrew Morton <akpm@osdl.org>
Cc: bunk@stusta.de, linux-kernel@vger.kernel.org, mchehab@infradead.org,
       js@linuxtv.org, v4l-dvb-maintainer@linuxtv.org
Subject: Re: [-mm patch] drivers/media/video/bt866.c: small fixes
Message-Id: <20060405154445.24c9bab5.sam@home.se>
In-Reply-To: <20060405004212.47312021.akpm@osdl.org>
References: <20060404014504.564bf45a.akpm@osdl.org>
	<20060404163001.GO6529@stusta.de>
	<20060404203219.40fe6b4c.sam@home.se>
	<20060405004212.47312021.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Apr 2006 00:42:12 -0700
Andrew Morton <akpm@osdl.org> wrote:

> Martin Samuelsson <sam@home.se> wrote:
> >
> > This should fix all things Andrew pointed out when I first submitted the 
> >  avs6eyes driver.
> 
> We still have all that #ifdef MODULE stuff at the end of bt866.c. 
> (Shouldn't it have module_init() and module_exit() handlers?)

I'm sorry for the confusion. I simply didn't want to cause a conflict with Adrian's patch, and canceled out those things from my version.

> All those ".input_mux = 0," lines you added to the struct initialisation
> are unneeded - the compiler did that for you.

Ah. I didn't know that. It's noted, and will be used in the future. I added them mostly in an attempt to aim for clarity and completeness.

Regards,
/Sam
