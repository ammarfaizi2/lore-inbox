Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264472AbTEJTGk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 15:06:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264473AbTEJTGj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 15:06:39 -0400
Received: from modemcable204.207-203-24.mtl.mc.videotron.ca ([24.203.207.204]:38018
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S264472AbTEJTGe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 15:06:34 -0400
Date: Sat, 10 May 2003 15:10:11 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Simon Matthews <simon@paxonet.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Problems with DRM/R128
In-Reply-To: <Pine.LNX.4.44.0305101124230.8905-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.50.0305101507400.11047-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.44.0305101124230.8905-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 May 2003, Simon Matthews wrote:

> I have an ATI Rage 128. I am using the 2.4.20 vanilla kernel. I have 
> compiled in the DRM 4.1 and the R128 driver (not as modules, but part of 
> the kernel). 
> 
> However, graphics such as tuxracer are very slow. The XFree86 log file 
> shows an entry:
> (II) R128(0): [drm] Added 128 16384 byte vertex/indirect buffers
> (II) R128(0): [drm] Mapped 128 vertex/indirect buffers
> (II) R128(0): [drm] failure adding irq handler, there is a device already 
> using that irq
> [drm] falling back to irq-free operation
> (II) R128(0): Direct rendering enabled

Looks ok, how uptodate is the DRM in the 2.4 mainline kernel anyway?

> On starting OpenOffice, I see: 
>  ooffice
> Gnome session manager detected - session management disabled
> running openoffice.org setup...
> Setup complete.  Running openoffice.org...
> libGL error: failed to open DRM: Operation not permitted
> libGL error: reverting to (slow) indirect rendering

Perhaps you don't have permissions to use DRI? The following would allow 
global access.

Section "dri"
        Mode 0666
EndSection

-- 
function.linuxpower.ca
