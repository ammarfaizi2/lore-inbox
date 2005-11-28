Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932244AbVK1X7h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932244AbVK1X7h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 18:59:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932293AbVK1X7h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 18:59:37 -0500
Received: from xproxy.gmail.com ([66.249.82.202]:29744 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932244AbVK1X7g convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 18:59:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=T+l4b3TmS16FnyNrC2OrbJ0YECQGycLlbpDjuSoRB1/bdfIGopWWZbFf/gt5BvGXzlU70j/289puT85CyK7Iv2zlxkU7E9A485k4gJvLdeOWFYPceO9tcs51oGhxqIOf9kdJxMX1MRBG5UN8IBIN7xvjYUn4IxF6SrtlxQccpLA=
Message-ID: <d120d5000511281559r6c6ed9edgc17e3a64453bf75d@mail.gmail.com>
Date: Mon, 28 Nov 2005 18:59:35 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: jt <jt@jtholmes.com>
Subject: Re: psmouse.c in Kernel fails but succeeds as Module
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <438B8861.1050408@jtholmes.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <438B8861.1050408@jtholmes.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/28/05, jt <jt@jtholmes.com> wrote:
>
> However, when  I compile Kernel with
>
> CONFIG_MOUSE_PS2=m
>
...
>
> the Alps GlidePoint is detected thus
>
>
> I: Bus=0011 Vendor=0002 Product=0008 Version=0000
> N: Name="PS/2 Mouse"
> P: Phys=isa0060/serio1/input1
> H: Handlers=mouse1 event3
> B: EV=7
> B: KEY=70000 0 0 0 0 0 0 0 0
> B: REL=3
>
> I: Bus=0011 Vendor=0002 Product=0008 Version=7321
> N: Name="AlpsPS/2 ALPS GlidePoint"
> P: Phys=isa0060/serio1/input0
> H: Handlers=mouse2 event4
> B: EV=f
> B: KEY=420 0 70000 0 0 0 0 0 0 0 0
> B: REL=3
> B: ABS=1000003
>
> and GlidePoint Works fine in Console Mode and X etc.
>

This is most likely USB legacy emulation screws up touchpad detection.
If you boot with "usb-handoff" on the kernel command line it shoudl
detect ALPS even if psmouse is built-in and not a module.

One of these days we will turn it on by default...

> I have my work around for the problem, but wondered if
> someone like Dimitry T. would like me to perform a little
> debugging and send them the output so others wont have
> to face this problem.
>

Would be easier if you CC me if you want me to see your message faster ;)

--
Dmitry
