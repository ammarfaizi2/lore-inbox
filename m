Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316046AbSEJP3L>; Fri, 10 May 2002 11:29:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316048AbSEJP3K>; Fri, 10 May 2002 11:29:10 -0400
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:56070 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316046AbSEJP3I>; Fri, 10 May 2002 11:29:08 -0400
Date: Fri, 10 May 2002 16:29:02 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: how to redirect serial console to telnet session?
Message-ID: <20020510162902.C7165@flint.arm.linux.org.uk>
In-Reply-To: <3CDBC5A5.A1844CC0@nortelnetworks.com> <20020510160945.B7165@flint.arm.linux.org.uk> <3CDBD9EA.1826BB48@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 10, 2002 at 10:32:10AM -0400, Chris Friesen wrote:
> I found some patches by Ingo Molnar, but they look like kernel mods.

That's the one.

> What I'm really looking for is a way to redirect this from userspace in
> a stock kernel.

There isn't anything in the stock kernel that will let you do this
without some form of patches being applied.

> I want the serial console as normal, but then for just debugging this
> one thing I want to telnet in over ethernet and basically redirect /dev/ttyS0
> onto my telnet session.

telnet (and its associated protocol) is a completely different beast to
serial consoles - in fact any network connection is.

If you really want to get at the kernel message data, there's dmesg
or a simple cat /proc/kmsg.  The problem with these is, when the kernel
crashes, you won't get the last messages.  Also, if you're generating
more than 16K of messages before allowing the kernel to continue (and
thus user space) you're also going to loose messages.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

