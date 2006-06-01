Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965161AbWFACVU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965161AbWFACVU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 22:21:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751667AbWFACVT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 22:21:19 -0400
Received: from wx-out-0102.google.com ([66.249.82.203]:35277 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751500AbWFACVT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 22:21:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=KdRJgHJnNec7NJvQirNnqiPKgq8Xk5NLLD8Hst9gTVytG6EAF4BjSZps4UKrtTZFdAInvwFKiykV4W4TmVIIfEafzKA9LoZz7/ZN+hkAjAyiNE3OjF/xk/Xes+WeiHND4Ir9Flb7HQb8m9hsGj85hu9opGqK3ckfcjMWEkLR67M=
Message-ID: <447E4F0C.1000202@gmail.com>
Date: Thu, 01 Jun 2006 10:21:00 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
CC: Geert Uytterhoeven <geert@linux-m68k.org>,
       Ondrej Zajicek <santiago@mail.cz>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: OpenGL-based framebuffer concepts
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>	 <200605272245.22320.dhazelton@enter.net>	 <9e4733910605272027o7b59ea5n5d402dabdd7167cb@mail.gmail.com>	 <200605280112.01639.dhazelton@enter.net>	 <21d7e9970605281613y3c44095bu116a84a66f5ba1d7@mail.gmail.com>	 <9e4733910605281759j2e7bebe1h6e3f2bf1bdc3fc50@mail.gmail.com>	 <Pine.LNX.4.63.0605301033330.4786@qynat.qvtvafvgr.pbz>	 <20060530223513.GA32267@localhost.localdomain>	 <447CD367.5050606@gmail.com>	 <Pine.LNX.4.62.0605312033260.16745@pademelon.sonytel.be> <9e4733910605311257m19450bbai4c3ae6fdc7909a4@mail.gmail.com>
In-Reply-To: <9e4733910605311257m19450bbai4c3ae6fdc7909a4@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl wrote:
> On 5/31/06, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> On Wed, 31 May 2006, Antonino A. Daplas wrote:
>> > And it can be done.  The matrox driver in 2.4 can do just that.  For
>> 2.6,
>> > we have tileblitting which is a drawing method that can handle pure
>> text.
>> > None of the drivers use this, but vgacon can be trivially written as a
>> > framebuffer driver that uses tileblitting (instead of the default
>> bitblit).
>> >
>> > I believe that there was a vgafb driver before that does exactly
>> what you
>> > want.
>>
>> Indeed. Early 2.1.x had a vgafb and an fbcon-vga, before vgacon
>> existed in its
>> current form.
> 
> Moving back to a vgafb with text mode support in fbcon would be one
> way to eliminate a few of the way too many graphics drivers. I don't
> see any real downside side to doing this, does any one else see any
> problems?

An optional vgafb driver is probably a good idea. It's downside
is probably slower performance.

I may start work on a userland fb driver that can support both
graphics and text mode this weekend.

Tony
