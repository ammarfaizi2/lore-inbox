Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265328AbUAJT25 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 14:28:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265333AbUAJT25
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 14:28:57 -0500
Received: from smtp805.mail.sc5.yahoo.com ([66.163.168.184]:57715 "HELO
	smtp805.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265328AbUAJT24 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 14:28:56 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Pavel Machek <pavel@suse.cz>, kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>, vojtech@suse.cz
Subject: Re: Do not use synaptics extensions by default
Date: Sat, 10 Jan 2004 14:28:49 -0500
User-Agent: KMail/1.5.4
References: <20040110175930.GA1749@elf.ucw.cz>
In-Reply-To: <20040110175930.GA1749@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401101428.49358.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 10 January 2004 12:59 pm, Pavel Machek wrote:
> ..aka "make synaptics touchpad usable in 2.6.1" -- synaptics support
> is not really suitable to be enabled by default. You can not click by
> tapping the touchpad (well, unless you have very new X with right
> configuration, but than you can't go back to 2.4),

It is my understanding that by setting "Protocol" to "auto-dev" and
"Device" to "/dev/psaux" you can freely switch between 2.4 and 2.5.

>                                                    and touchpad senses
> your finger even when it is not touching, doing spurious movements =>
> you can't hit anything on screen. 

Does the touchpad sensitivity is OK for you when using then native XFree
driver? Should we bump it up a little?

Plus, there were issues in mousedev regarding PS2 emulation for touchpads
in absolute mode, it should be fixed in -mm or you can try grabbing patches
from http://www.geocities.com/dt_or/input/2_6_1/
You are probably mostly interesed in one that deals with mouse jitter.

>                                    Without synaptics extensions
> everything works just fine. You can reenable synaptics support using
> commandline.
>
> Plus it documents psmouse_noext option.
>

Why would you document something that is deprecated? It was removed so the
new users would not start using it instead of psmouse.proto. psmouse.noext
should be gone soon.

Plus, you not only disabling Synaptics extensions but Genius and Logitech's
ones as well.

> Please apply,
> 								Pavel

Dmitry
