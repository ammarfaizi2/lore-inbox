Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261724AbVBONoy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbVBONoy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 08:44:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261725AbVBONox
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 08:44:53 -0500
Received: from hermine.aitel.hist.no ([158.38.50.15]:10244 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S261724AbVBONot (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 08:44:49 -0500
Message-ID: <4211FD5A.9020705@aitel.hist.no>
Date: Tue, 15 Feb 2005 14:47:06 +0100
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: xerces8 <xerces8@butn.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Dummy vt for XFree86 ?
References: <WorldClient-F200502151033.AA33440074@butn.net>
In-Reply-To: <WorldClient-F200502151033.AA33440074@butn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

xerces8 wrote:

>Hi!
>
>Is there a way to prevent VT switching for XFree86 ?
>
>I have two gfx cards and want to start an X server on the secondary
>card, while leaving the VTs on the primary card active.
>
>So I need XFree86 not to allocate and cause a switch to a new VT.
>Since I know of no way to make XFree86 do that, I wonder if I can
>give XFree86 some fake vt on its command line, like :
>
>X :0 vt_dummy
>
>Is this possible with a 2.6.x series kernel ?
>
>Any other way to prevent X taking away "focus" from the primary card ?
>
>( please ignore any possible issues with the keyboard, that may arise
>when having X and text VT active at the same time )
>  
>
The keyboard is very much the issue - your typing either goes into
the VT on the primary card - or into the X session.  There is no other way
the computer can know what you mean.  I guess you're going to
run an X session that won't use kbd input at all, given the question you 
ask?

The stock 2.6.x can't do it, but take a look at the ruby patch.
Ruby is really meant for hooking up several keybaords, so you can have one
keboard for the VT's on your first card and another kbd for the X session.
This lets several users work at the same time, using only one pc.

If you don't need the scondary keyboard - don't plug one in.  Ruby can still
give you a dummy VT where no input or output happens, and X can use that VT.

Boot the ruby-patched 2.6.x kernel with the "dumbcon=1" parameter to get one
dummy console, and let X use VT17 which will be that dummy.

Helge Hafting
