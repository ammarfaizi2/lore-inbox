Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750930AbVLLADm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750930AbVLLADm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 19:03:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750931AbVLLADm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 19:03:42 -0500
Received: from zproxy.gmail.com ([64.233.162.207]:40087 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750929AbVLLADl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 19:03:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=l7nISDj7M/wYL1s7PChnCk6dmO1noALpfBDkkpEf5UgDhD1EKOmJsPg4i5pQWiEJwDUm6Owk2iEm1VIVEY2/Y+GBmvY6Rn3BD017pgUDFmw18p2u2JvXJEixe3mqkCUeVbNP/i0v52WMOQTQI4NLHfWYZ5KwTwqosapOEYOa+V4=
Message-ID: <439CBE49.2090901@gmail.com>
Date: Mon, 12 Dec 2005 08:03:21 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051025)
MIME-Version: 1.0
To: Jesper Juhl <jesper.juhl@gmail.com>
CC: LKML List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: Yet more display troubles with 2.6.15-rc5-mm2
References: <9a8748490512111306x3b01cb8cw2068a7ad3af93b03@mail.gmail.com>
In-Reply-To: <9a8748490512111306x3b01cb8cw2068a7ad3af93b03@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:
> In addition to the problem I reported earlier about 2.6.15-rc5-mm2
> hanging at boot with vga=791 I've just discovered another problem.
> 
> If I boot with vga=normal (which is aparently all that works), then I
> can boot up to a nice lain text login and run startx, but if I then
> switch away from X back to a text console with ctrl+alt+f6 or if I
> shut down X, then I'm presented with a completely garbled text mode
> screen - flashing coloured blocks all over, random bits of text at
> random locations etc.
> 
> Also, when starting X, just before the cursor appears I normally just
> have a black screen. With this kernel I first get a short blink of a
> garbled graphics mode screeen with either what looks like just random
> pixels or sometimes with something that looks like a mangled snapshot
> of my text mode console, or if I kill X with ctrl+alt+backspace and
> then start it again (the garbled text mode console does work, although
> I'm glad I know how to touch type ;) then I sometimes get what looks
> like a snapshot of my previous X session with random pixels on top.
> The garbled graphical screen stays for just a blink of an eye, then
> it's replaced with the normal black screen and the mouse cursor.
> 
> 2.6.15-rc5-git1 works perfectly without these issues.

I cannot reproduce your problem...

If set, can you comment out Load "dri" and/or Load "glx" from your
X config?

Can you try another X driver, ie, vesa?

Also, these 2 patches are present in mm but not in Linus' tree.  Can
you check which of these are the culprit, if any?

http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-rc2/2.6.15-rc2-mm1/broken-out/vgacon-fix-doublescan-mode.patch
http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-rc2/2.6.15-rc2-mm1/broken-out/vgacon-workaround-for-resize-bug-in-some-chipsets.patch

Tony
 
