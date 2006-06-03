Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030358AbWFCU4R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030358AbWFCU4R (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 16:56:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030354AbWFCU4R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 16:56:17 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:23243 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1030366AbWFCU4Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 16:56:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=lNb+ih/OCQjXeE9inX3ekBf1tfdtr18vH2KR8rNpI5H5Hl8EZPEUBXGVv0jG6xWzesn5Y3LHZVGUA2THT+q0qF5J69zBgwSt801hJV3LIl0zuhUZw0Ku6xVcENlguXOTBxz2w5bPyCJNu5Dqvjm4pZwzh8Z4QCxdPakJHA987eY=
Message-ID: <4481F75A.5030406@gmail.com>
Date: Sun, 04 Jun 2006 04:55:54 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Kyle Moffett <mrmacman_g4@mac.com>
CC: Pavel Machek <pavel@ucw.cz>, David Lang <dlang@digitalinsight.com>,
       Ondrej Zajicek <santiago@mail.cz>, Jon Smirl <jonsmirl@gmail.com>,
       Dave Airlie <airlied@gmail.com>, "D. Hazelton" <dhazelton@enter.net>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Manu Abraham <abraham.manu@gmail.com>, linux cbon <linuxcbon@yahoo.fr>,
       Helge Hafting <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Subject: Re: OpenGL-based framebuffer concepts
References: <21d7e9970605281613y3c44095bu116a84a66f5ba1d7@mail.gmail.com> <9e4733910605281759j2e7bebe1h6e3f2bf1bdc3fc50@mail.gmail.com> <Pine.LNX.4.63.0605301033330.4786@qynat.qvtvafvgr.pbz> <447CBEC5.1080602@gmail.com> <20060602083604.GA2480@localhost.localdomain> <20060602085832.GA25806@elf.ucw.cz> <Pine.LNX.4.63.0606021146320.4686@qynat.qvtvafvgr.pbz> <20060602220104.GA6931@elf.ucw.cz> <Pine.LNX.4.63.0606021256470.4686@qynat.qvtvafvgr.pbz> <4480C8D9.5080309@gmail.com> <20060603063251.GF6931@elf.ucw.cz> <448134AD.7060502@gmail.com> <A12E8656-AE17-43CA-B70E-350B19D78FA1@mac.com>
In-Reply-To: <A12E8656-AE17-43CA-B70E-350B19D78FA1@mac.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett wrote:
> On Jun 3, 2006, at 03:05:17, Antonino A. Daplas wrote:
>> Pavel Machek wrote:
>>> Well, you can only miss a message *you would not see anyway*.
>>
>> There are some things that one can see but not read, and still be
>> recognizable even if your console is scrolling by.
> 
> You would not even be able to recongnize it; we're talking about
> displaying text faster than the refresh rate, as pavel mentioned earlier:

We're talking about displaying a snapshot of the screen buffer at
specific intervals, perhaps during vblank.  And not all configurations
of framebuffers can scroll text that fast.  Just try vesafb at the
highest resolution and color depth without ypan and mtrr. (Default
for most distribs is vesafb at 1024x768-16, no ypan, no mtrr -- this
is a slow enough configuration that the scrolling text is recognizable,
Especially if you have a splash enabled, which further slows down
vesafb).

And the slower the console is, the more data that will fail to show
on the screen, the higher the likelihood of missing things, and the
uglier it will be.

Tony
