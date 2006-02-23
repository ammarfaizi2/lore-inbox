Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751128AbWBWMgj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751128AbWBWMgj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 07:36:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751140AbWBWMgj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 07:36:39 -0500
Received: from [195.23.16.24] ([195.23.16.24]:24488 "EHLO
	linuxbipbip.grupopie.com") by vger.kernel.org with ESMTP
	id S1751128AbWBWMgj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 07:36:39 -0500
Message-ID: <43FDAC54.5030303@grupopie.com>
Date: Thu, 23 Feb 2006 12:36:36 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Andrew Morton <akpm@osdl.org>, Kay Sievers <kay.sievers@suse.de>,
       penberg@cs.helsinki.fi, gregkh@suse.de, bunk@stusta.de, rml@novell.com,
       linux-kernel@vger.kernel.org, johnstul@us.ibm.com
Subject: Re: 2.6.16-rc4: known regressions
References: <Pine.LNX.4.64.0602171438050.916@g5.osdl.org> <20060217231444.GM4422@stusta.de> <84144f020602190306o3149d51by82b8ccc6108af012@mail.gmail.com> <20060219145442.GA4971@stusta.de> <1140383653.11403.8.camel@localhost> <20060220010205.GB22738@suse.de> <1140562261.11278.6.camel@localhost> <20060221225718.GA12480@vrfy.org> <20060221153305.5d0b123f.akpm@osdl.org> <20060222000429.GB12480@vrfy.org> <20060221162104.6b8c35b1.akpm@osdl.org> <Pine.LNX.4.64.0602211631310.30245@g5.osdl.org> <Pine.LNX.4.64.0602211700580.30245@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602211700580.30245@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> [...]
> Side note: if people want to, we could have other "trampolines" like that, 
> so that we could have more user-level code that gets distributed with the 
> kernel. It doesn't have to be something that gets mapped into every binary 
> either: we could - if we wanted to - have things like shared libraries or 
> helper shell scripts or whatever that we expose in /sys/shlib/ that are 
> kernel-version dependent.

Do you envision this being used for stuff like libalsa, libusb, a v4l2 
lib, etc.?

I always felt that this kind of libraries are sort of "part of the 
kernel" in the sense that programs really do need them to interface with 
the kernel. (*)

If we had a privelidged libv4l2 library like that then things like 
format conversion and video encoding / decoding could be done in user 
space and we could provide a more "high level" standard interface for 
user programs.

This is the sort of thing that libalsa already does with audio software 
mixing (for instance) with the advantage that we need to keep the 
interface between libalsa and the kernel across kernel versions.

Of course, the interface exported by these libraries would now be the 
official kernel interface.

-- 
Paulo Marques - www.grupopie.com

Pointy-Haired Boss: I don't see anything that could stand in our way.
            Dilbert: Sanity? Reality? The laws of physics?

(*) Yeah, one can write programs that don't use the libraries, but that 
is just asking for trouble...
