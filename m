Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267621AbTAHBmh>; Tue, 7 Jan 2003 20:42:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267625AbTAHBmh>; Tue, 7 Jan 2003 20:42:37 -0500
Received: from h55p111.delphi.afb.lu.se ([130.235.187.184]:14250 "EHLO
	gagarin.0x63.nu") by vger.kernel.org with ESMTP id <S267621AbTAHBmg> convert rfc822-to-8bit;
	Tue, 7 Jan 2003 20:42:36 -0500
Date: Wed, 8 Jan 2003 02:51:07 +0100
To: Joshua Kwan <joshk@ludicrus.ath.cx>
Cc: linux-kernel@vger.kernel.org, vojtech@suse.cz
Subject: Re: [2.5.54-dj1-bk] Some interesting experiences...
Message-ID: <20030108015107.GA2170@gagarin>
References: <20030107172147.3c53efa8.joshk@ludicrus.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20030107172147.3c53efa8.joshk@ludicrus.ath.cx>
User-Agent: Mutt/1.4i
From: Anders Gustafsson <andersg@0x63.nu>
X-Scanner: exiscan *18W5N5-00086H-00*Ssh41eSC.Qw* (0x63.nu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2003 at 05:21:46PM -0800, Joshua Kwan wrote:
> 
> 3. [linux-2.5] PS/2 mouse goes haywire every 30 seconds or so of use.
> dmesg sayeth:
> mice: PS/2 mouse device common for all mice
> input: PS/2 Synaptics TouchPad on isa0060/serio4
> 
> but more importantly this is the cause:
> 
> psmouse.c: Lost synchronization, throwing 2 bytes away.
> psmouse.c: Lost synchronization, throwing 2 bytes away.

This happens here too. But not that frequent at all, more like once every
hour. And has happend on all kernels since at least 2.5.46 [1].

However 5 hours ago I changed the timeout in psmouse.c from 50ms to 100ms.
And now it haven't misbehaved yet, but that might be just some nightly luck. 
Is there something that turns off interupts or something and hinders the
mouse driver from processing the data for such long time? Or is my hardware
just buggy?

[1] http://marc.theaimsgroup.com/?l=linux-kernel&m=103688231622278&w=2

-- 
Anders Gustafsson - andersg@0x63.nu - http://0x63.nu/
