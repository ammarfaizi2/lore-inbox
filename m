Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932584AbWFCHFi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932584AbWFCHFi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jun 2006 03:05:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932588AbWFCHFi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jun 2006 03:05:38 -0400
Received: from wx-out-0102.google.com ([66.249.82.192]:63752 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932584AbWFCHFh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jun 2006 03:05:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=d2CnDxisV1alqNhoodxOxnCJmTxKIFuGUGlJxahSJDxM4w7QfpfH6brl5ZlviKvX09MzsfhNNnVp7Jb/9oRRg2Kp8eyY62Yl7wEdAY3Ujpjr2UBX+fkbNvtx3aIi3zp7WVcpluZ6R5Ws0/oZEHiDfkWFIiJQRqPqQjPmBo2LjII=
Message-ID: <448134AD.7060502@gmail.com>
Date: Sat, 03 Jun 2006 15:05:17 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: David Lang <dlang@digitalinsight.com>, Ondrej Zajicek <santiago@mail.cz>,
       Jon Smirl <jonsmirl@gmail.com>, Dave Airlie <airlied@gmail.com>,
       "D. Hazelton" <dhazelton@enter.net>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Kyle Moffett <mrmacman_g4@mac.com>,
       Manu Abraham <abraham.manu@gmail.com>, linux cbon <linuxcbon@yahoo.fr>,
       Helge Hafting <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Subject: Re: OpenGL-based framebuffer concepts
References: <21d7e9970605281613y3c44095bu116a84a66f5ba1d7@mail.gmail.com> <9e4733910605281759j2e7bebe1h6e3f2bf1bdc3fc50@mail.gmail.com> <Pine.LNX.4.63.0605301033330.4786@qynat.qvtvafvgr.pbz> <447CBEC5.1080602@gmail.com> <20060602083604.GA2480@localhost.localdomain> <20060602085832.GA25806@elf.ucw.cz> <Pine.LNX.4.63.0606021146320.4686@qynat.qvtvafvgr.pbz> <20060602220104.GA6931@elf.ucw.cz> <Pine.LNX.4.63.0606021256470.4686@qynat.qvtvafvgr.pbz> <4480C8D9.5080309@gmail.com> <20060603063251.GF6931@elf.ucw.cz>
In-Reply-To: <20060603063251.GF6931@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> On So 03-06-06 07:25:13, Antonino A. Daplas wrote:
>> David Lang wrote:
>>> On Sat, 3 Jun 2006, Pavel Machek wrote:
>>>> I'm not talking about reading speed, I'm talking about displaying
>>>> speed. Once you display more than refresh rate times screen
>>>> size... you may as well cheat -- xterm-like. If xterm detects too much
>>>> stuff is being displayed, it simply stops displaying it, only
>>>> refreshing screen few times a second...
>>> That would work, however AFAIK it's not implemented in any existing
>>> framebuffer.
>> Besides implementaton, the main concern with this is that you might miss
>> a very important kernel message.  Though one can always use the scrollback
>> buffer.
> 
> Well, you can only miss a message *you would not see anyway*.

There are some things that one can see but not read, and still be
recognizable even if your console is scrolling by.

An oops tracing, for one, is very unique and it's easy to pick them off
from regular text, especially on a relatively slow console such as vesafb.
We may even choose to colorize the output so they can stand out further.
  
> I guess
> the main concern is that it tends to look ugly on the screen (and it
> will not be quite easy code).
> 
> Anyway, no, I do not think it is needed. framebuffers are fast enough

I agree, I don't think it's needed.

Tony
