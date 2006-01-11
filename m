Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932316AbWAKLut@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932316AbWAKLut (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 06:50:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932375AbWAKLut
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 06:50:49 -0500
Received: from zproxy.gmail.com ([64.233.162.207]:48272 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932316AbWAKLut (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 06:50:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=SYK704eiuSW/zRtekGd2vNyx4JVE1q8l/PCynlFZIVEpMu1lBTR6YmzcfCORzVII+IqvoZaGFgI/9Cc1VRsEFcaGnTqKDiVyrIYKJZ1vhTD5WyP04EDn1lEin7BapeQPy2KQzDYb6oj2qXojpZoWm/GJ6M/7Kt98cAXfyIBTAAA=
Message-ID: <43C4F114.9070308@gmail.com>
Date: Wed, 11 Jan 2006 19:50:44 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Alexey Dobriyan <adobriyan@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-$SHA1: VT <-> X sometimes odd
References: <20060110162305.GA7886@mipter.zuzino.mipt.ru>
In-Reply-To: <20060110162305.GA7886@mipter.zuzino.mipt.ru>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Dobriyan wrote:
> Approximate sequence of event:
> 
> 1. script which builds allmodconfig on 11 targets is left on otherwise
>    idle machine. Logged in on VT1. Logged of X.
> 2. After 5 hours I return, ensure script behaves OK, switch to X and see
>    black screen.
> 3. Now, trying to switch between VTs and X gives nothing but black
>    screen.
> 4. Alt+SysRq+K. After several seconds black screen switches to black
>    screen with text cursor in the upper-left corner.
> 5. Futher attempts to switch and SysRq+Ki'ing gave nothing.
> 6. In a minute or so X login prompt reappeared. Mouse os OK. Keyboard is
>    not. In particular, typing username doesn't work.
> 7. By some miracle, typing became OK (probably after I hit Ctrl, not
>    sure). I login to X successfully and fire up mutt to mail bugreport.
> 8. Devil turned me to switch to VT again...
> 9. goto #5.
> 10. Cold reboot.

Can you reproduce this with another X driver, for example, vesa or
fbdev, and/or with another console driver? Maybe you can also try with
DRI enabled and disabled?
 
> 
> The overall feeling is that X left without human interaction starts to
> reacts slooowly (probably after blanking kicks in?).

That's also what I'm thinking, console blanking, X blanking, or power
management. You might want to shorten the console blanking interval with:

setterm -blank 1.

Tony
