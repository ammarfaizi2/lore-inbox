Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265461AbTL2Xn5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 18:43:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265478AbTL2Xn5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 18:43:57 -0500
Received: from smtp811.mail.sc5.yahoo.com ([66.163.170.81]:42852 "HELO
	smtp811.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265461AbTL2Xnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 18:43:53 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: walt <wa1ter@myrealbox.com>, linux-kernel@vger.kernel.org
Subject: Re: PS2 mouse changes for 2.6
Date: Mon, 29 Dec 2003 18:43:44 -0500
User-Agent: KMail/1.5.4
References: <3FF033AF.2080905@myrealbox.com>
In-Reply-To: <3FF033AF.2080905@myrealbox.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312291843.44656.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 29 December 2003 09:01 am, walt wrote:
> I get good results from last night's PS2 mouse patches.  My one
> problem machine now works perfectly again without the psmouse_noext
> parameter I've been using for several months.
>
> Two observations:
>
> I see no deprecation warnings when starting the kernel with
> psmouse_noext, which I was expecting to see.

It is emitted with KERN_WARNING severity and is not necessary seen on
the console. Check you dmesg.
>
> The mouse is announced as a 'generic wheel mouse', but it is
> really a Kensington Orbit trackball.  Unfortunately I don't
> have a wheel mouse to test with, so I can't comment there.
>

The kernel does not really distinguish between different hardware
manufacturers. It tries to recognize Synaptics, Logitech and Genius, but
it relies on mouse responses to various PS/2 protocol probes. Anything
that responds to IntelliMouse (imps) protocol probes but does not respond
to ImtelliMouse Explorer (exps) probes gets labelled as "Generic Wheel
Mouse".

Dmitry
