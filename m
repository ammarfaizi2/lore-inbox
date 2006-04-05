Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751152AbWDEHtk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751152AbWDEHtk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 03:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751055AbWDEHtk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 03:49:40 -0400
Received: from smtp.osdl.org ([65.172.181.4]:38311 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751062AbWDEHtj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 03:49:39 -0400
Date: Wed, 5 Apr 2006 00:42:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: Martin Samuelsson <sam@home.se>
Cc: bunk@stusta.de, linux-kernel@vger.kernel.org, mchehab@infradead.org,
       js@linuxtv.org, v4l-dvb-maintainer@linuxtv.org
Subject: Re: [-mm patch] drivers/media/video/bt866.c: small fixes
Message-Id: <20060405004212.47312021.akpm@osdl.org>
In-Reply-To: <20060404203219.40fe6b4c.sam@home.se>
References: <20060404014504.564bf45a.akpm@osdl.org>
	<20060404163001.GO6529@stusta.de>
	<20060404203219.40fe6b4c.sam@home.se>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Samuelsson <sam@home.se> wrote:
>
> This should fix all things Andrew pointed out when I first submitted the 
>  avs6eyes driver.

We still have all that #ifdef MODULE stuff at the end of bt866.c. 
(Shouldn't it have module_init() and module_exit() handlers?)

All those ".input_mux = 0," lines you added to the struct initialisation
are unneeded - the compiler did that for you.


