Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932099AbWHNPNk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbWHNPNk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 11:13:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751446AbWHNPNk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 11:13:40 -0400
Received: from wx-out-0506.google.com ([66.249.82.234]:21968 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751267AbWHNPNk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 11:13:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MUbcpycjvX/VrY5rzL/yFVAeXoO9rLdp0SG+Tajo/KWkdvkGVxwsOOa0gknSt1qgf9J32TX3ARzCz11Z1ZGT/qkaZcotw/nDMWrFeS5QiCK68N16KrS/KxEinCLuaGbh7ajr+ev5Q5BPB1CzsYdhyzPhGp5Z60k8q55KalFzEEU=
Message-ID: <d120d5000608140813i353b8efaia27d6213b08aff98@mail.gmail.com>
Date: Mon, 14 Aug 2006 11:13:38 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Gene Heskett" <gene.heskett@verizon.net>
Subject: Re: Touchpad problems with latest kernels
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200608141038.04746.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <BAY114-F2C4913B499BE3113C8E9BFA4E0@phx.gbl>
	 <200608141038.04746.gene.heskett@verizon.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

HI Gene,

On 8/14/06, Gene Heskett <gene.heskett@verizon.net> wrote:
>
> I'm having similar problems with an HP Pavilian dv5220, and with a
> bluetooth mouse dongle plugged into the right side usb port it works just
> fine.  What I'd like to do is totally disable that synaptics pad as its
> way too sensitive,

Are you using synaptics X driver? It can be tweaked to adjust
sensitivity and lots of other things.

> making it impossible to type more than a line or 2
> without the cursor suddenly jumping to someplace else in the message,
> often highliteing several lines of text as it goes, and the next keystroke
> then deletes wholesale quantities of text, thoroughly destroying any
> chance of actually writing a cogent, understandable email response to
> anyone.
>

Have you tried synclient utility? It temporarily disables the touchpad
when you start typing and re-enables it when you done.

> Unforch, my questions along those lines have been treated as the ravings of
> a lunatic and ignored.  The bios has no place to disable it, dumbest bios
> I've seen in quite a while, and it has been updated in the last 3 months.
>
> I don't *think* I'm a lunatic, but I'm equally sure that the synaptics is a
> pain in the ass and should be capable of being totally disabled somehow,
> hopefully short of opening the lappy up and unplugging or cutting every
> lead to it until such time as it can be made to behave instead of
> responding to every thumb waved 1/2 to 3/4" above it.  I've gotten hand
> cramps trying to hold my thumbs far enough away from that abomination to
> stop such goings on.
>
> So count this as a vote FOR doing something about the synaptics touchpad
> situation.
>

There are ways to disable it:

echo -n "manual" > /sys/bus/serio/devices/serioX/bind_mode
echo -n "none" > /sys/bus/serio/devices/serioXdrvctl

This should disable it completely.

-- 
Dmitry
