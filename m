Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263105AbTCSTPG>; Wed, 19 Mar 2003 14:15:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263111AbTCSTPG>; Wed, 19 Mar 2003 14:15:06 -0500
Received: from adsl-63-195-13-70.dsl.chic01.pacbell.net ([63.195.13.70]:38593
	"EHLO mail.scitechsoft.com") by vger.kernel.org with ESMTP
	id <S263105AbTCSTPE>; Wed, 19 Mar 2003 14:15:04 -0500
From: "Kendall Bennett" <KendallB@scitechsoft.com>
Organization: SciTech Software, Inc.
To: <linux-kernel@vger.kernel.org>
Date: Wed, 19 Mar 2003 11:25:45 -0800
MIME-Version: 1.0
Subject: Re: Help with patch for vesafbd support again?
Message-ID: <3E7853B9.13125.8F8AA5C@localhost>
In-reply-to: <1409.4.64.238.61.1048042813.squirrel@www.osdl.org>
References: <3E77584D.959.5228A36@localhost>
X-mailer: Pegasus Mail for Windows (v4.02)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" <rddunlap@osdl.org> wrote:

> > Finally, before I embark on this project, will this patch will be  accepted
> > into the kernel source code tree? I would hate to spend my time  on it only
> > to find out that the kernel developers don't like it and won't  accept it.
> 
> Can (will) you say *why* you want this?  I can't find that info here.

Why? I thought that would be clearly obvious. Right now with the VESA 
framebuffer device driver you cannot change the mode on the graphics card 
once the system has started. You are also restricted to only working with 
VESA 2.0 cards that have functional 32-bit protected mode functions if 
you wish to support panning and proper color map progamming, which is not 
always possible (believe me, I know of many that will not work unless you 
play magic with the selectors passed to the functions; something Linux 
cannot do).

With the vesafbd driver it is possible to use 'fbset' to change the 
active console display mode at any time after the system has booted, as 
well as use the fallback BIOS functions to program the palette and pan 
the display. Not as fast as the VBE 2.0 functions, but if the VBE 2.0 
functions are broken this is a good compromise.

On top of that I already mentioned the fact that it would allow 
framebuffer console drivers to be developed inside the daemon that could 
be implemented using XFree86 4.0 modules if desired (ie: sharing source 
code with XFree86 rather than having completely separate framebuffer 
console modules developed for all the same graphics cards).

> and can you post the patch file (source code) that you have
> somewhere, like a web page (not email if it's large)? 

The patch is not very large. However I have put the original release 
files up on my private web page for people to download and examine:

http://www.scitechsoft.com/~kendallb/vesafbd/vesafb-20000122.patch

http://www.scitechsoft.com/~kendallb/vesafbd/vesafbd-0.1.tar.gz

Regards,

---
Kendall Bennett
Chief Executive Officer
SciTech Software, Inc.
Phone: (530) 894 8400
http://www.scitechsoft.com

~ SciTech SNAP - The future of device driver technology! ~

