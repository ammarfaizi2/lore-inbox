Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261365AbVGLMs5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261365AbVGLMs5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 08:48:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261391AbVGLMs5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 08:48:57 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:727 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S261365AbVGLMs4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 08:48:56 -0400
Message-ID: <42D3BDDA.3050905@aitel.hist.no>
Date: Tue, 12 Jul 2005 14:55:54 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: subramanyam yenugonda <subramanyamy@yahoo.co.in>
CC: linux-kernel@vger.kernel.org
Subject: Re: opening the framebuffer device
References: <20050711114712.95478.qmail@web8406.mail.in.yahoo.com>
In-Reply-To: <20050711114712.95478.qmail@web8406.mail.in.yahoo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

subramanyam yenugonda wrote:

>Hi All!
>
>How to open the frame buffer device if user has
>multiple monitors on single video card.
>
>Thanks in advance.
>~YSM
>  
>
You open the _correct_ framebuffer device.
Linux support multiple framebuffer devices, e.g.
/dev/fb0  /dev/fb1 /dev/fb2 ...

The matrox G550 support this, set the correct kernel config options
and you get both /dev/fb0 and /dev/fb1 (for the second head.)

This is the way to go if you want _independent_ monitors.

Some other drivers create a large framebuffer that spans several
monitors - ideal for the common case of one big desktop spread
across several monitors.  In those cases, you open /dev/fb0,
and find the different monitor bitmaps at different offsets inside that 
file.

Helge Hafting
