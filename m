Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262319AbTFBN1c (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 09:27:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262320AbTFBN1c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 09:27:32 -0400
Received: from main.gmane.org ([80.91.224.249]:7371 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262319AbTFBN1b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 09:27:31 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Thomas Backlund" <tmb@iki.fi>
Subject: Re: [PATCH 2.4.21-rc6-ac1] vesafb fixes...
Date: Mon, 2 Jun 2003 16:40:02 +0300
Message-ID: <bbfjv8$gpe$1@main.gmane.org>
References: <200306011930.02086.tmb@iki.fi>
X-Complaints-To: usenet@main.gmane.org
X-Newsreader: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


AARGH...
I forgot to rediff...,
but since it seems to break the bootsplash,
the vesafb.c.diff needs more work...

but the vesafb.txt.diff should be applied...

"Thomas Backlund" <tmb@iki.fi> wrote in message
news:200306011930.02086.tmb@iki.fi...
> Here are 2 patches...
>
> The "vesafb.txt.diff" removes duplicate text in the documentation...
>
> The "vesafb.c.diff" changes the following:
>  - it adds "* 2" to the video_size calculation to remap enough memory
>    to do double buffering
>
>  - to make sure that our double buffering calculation does not remap
>    more memory than old cards actually have it uses the "old" code:
>
> if video_size > (screen_info.lfb_size * 65536)
> video_size = screen_info.lfb_size * 65536;
>

Stupid typos... :-(

I am using:
if (video_size > (screen_info.lfb_size * 65536))
        video_size = screen_info.lfb_size * 65536;


>  - and last but not least it changes my override to work both ways,
>    so that the user can specify less or more memory to be remapped
>
>
> I earlier got a comment that this double buffering thing is not needed,
> but IMHO there will always be cards out there that are to new, so they
> dont have driver support (yet), or they are too "weird" so the only thing
> the user has to rely on is the vesafb driver, and I like the idea to get
> atleast this support "out of the box"...
>

 Best Regards

 Thomas



