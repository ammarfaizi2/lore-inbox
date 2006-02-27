Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932098AbWB0TwI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098AbWB0TwI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 14:52:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932084AbWB0TwI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 14:52:08 -0500
Received: from lucidpixels.com ([66.45.37.187]:7058 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S932098AbWB0TwF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 14:52:05 -0500
Date: Mon, 27 Feb 2006 14:52:04 -0500 (EST)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34
To: Jesper Juhl <jesper.juhl@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Question regarding call trace.
In-Reply-To: <9a8748490602271133o4aa673e4x3c069c1ab08fc392@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0602271452010.5678@p34>
References: <Pine.LNX.4.64.0602271411020.5678@p34>
 <9a8748490602271133o4aa673e4x3c069c1ab08fc392@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the information.

On Mon, 27 Feb 2006, Jesper Juhl wrote:

> On 2/27/06, Justin Piszcz <jpiszcz@lucidpixels.com> wrote:
>> I have a trace that looks like the following, my question is, are the
>> process(es) at the top of the call trace responible for the actual crash
>> of the machine?  Are they the root cause?
>>
>
> As a general rule, functions near the top of a trace are more likely
> to be the cause of the crash than functions near the bottom, but
> that's not always the case.
> Also sometimes when dealing with race conditions some part of the
> kernel messes up and causes a different part of the kernel to crase so
> that what you see in the trace is not what actually *caused* the
> problem but merely what was affected by a problem somewhere else.
> And if there's memory corruption going on then sometimes one part of
> the kernel can scrible on random memory and cause a different and
> completely unrelated part of the kernel to blow up.
> So you cannot always trust a call trace 100%.
>
>
>> Would this point to a bad SCSI board?
>>
> I'm sorry, I can't tell you :(
>
> You might want to try enable debugging symbols and frame pointers to
> get a more readable trace.
>
> Consider these options (in the Kernel Hacking section of menuconfig) :
>  CONFIG_DEBUG_KERNEL
>  CONFIG_DEBUG_INFO
>  CONFIG_FRAME_POINTER
>  CONFIG_UNWIND_INFO
>
> There are other options in there as well that may help, read their
> description and decide for yourself if you think they will be needed -
> or maybe someone else who understands your dump better than me can
> advice on what specific options to enable.
>
> Hope this helps you.
>
> --
> Jesper Juhl <jesper.juhl@gmail.com>
> Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
> Plain text mails only, please      http://www.expita.com/nomime.html
>
