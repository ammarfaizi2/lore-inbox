Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261841AbTC0Joa>; Thu, 27 Mar 2003 04:44:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261842AbTC0Joa>; Thu, 27 Mar 2003 04:44:30 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:2565 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S261841AbTC0Jo3>; Thu, 27 Mar 2003 04:44:29 -0500
Message-ID: <3E82CB28.8020001@aitel.hist.no>
Date: Thu, 27 Mar 2003 10:58:00 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: no, en
MIME-Version: 1.0
To: James Simmons <jsimmons@infradead.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: Much better framebuffer fixes.
References: <Pine.LNX.4.44.0303270017180.25001-100000@phoenix.infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Simmons wrote:
> Okay. Here are more framebuffer fixes. Please try these fixes and let me 
> know how they work out for you.
> 

The cursor line on radeonfb now is solid, instead of the broken line
in 2.5.66.  It is still impossible to set the resolution.

The lilo approach:
append="video=radeonfb:1280x1024-24@60"
This seems to do nothing.  I get the same low resolution as
plain 2.5.66, which looks bad as it don't match the flat screen resolution.

The stty approach:
stty rows 64 cols 160 gives me an odd error message about
stdin being wrong.  Forcing it with -F /dev/tty
gives me lots of random colored text on the screen and the
scrolling is wrong afterwards.  Resolution don't change though.
I run devfs if that matters.

stty rows 25 cols 80 brought things back to normal, or so it seemed.
I switched back to X and noticed that most programs except ls
wouldn't run, they all segfaulted.  Something was wrong, and
a shutdown ended in a BUG in slab.c line 1557 and a hang.


A new thing with this patch is that I get a lot of junk displayed
to the side of the boot penguin. (Random colored letters).
  The junk disappear after a little while though.

Helge Hafting


