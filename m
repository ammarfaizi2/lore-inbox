Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263769AbUJ3A3C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263769AbUJ3A3C (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 20:29:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263751AbUJ3A2t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 20:28:49 -0400
Received: from smtp-out.hotpop.com ([38.113.3.61]:65495 "EHLO
	smtp-out.hotpop.com") by vger.kernel.org with ESMTP id S263740AbUJ3AZy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 20:25:54 -0400
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: linux-fbdev-devel@lists.sourceforge.net,
       Mark Fortescue <mark@mtfhpc.demon.co.uk>, jsimmons@infradead.org,
       geert@linux-m68k.org
Subject: Re: [Linux-fbdev-devel] Help re Frame Buffer/Console Problems
Date: Sat, 30 Oct 2004 08:25:47 +0800
User-Agent: KMail/1.5.4
Cc: sparclinux@vger.kernel.org, ultralinux@vger.kernel.org,
       linux-kernel@vger.kernel.org, wli@holomorphy.com
References: <Pine.LNX.4.10.10410291849480.2831-100000@mtfhpc.demon.co.uk>
In-Reply-To: <Pine.LNX.4.10.10410291849480.2831-100000@mtfhpc.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410300825.47096.adaplas@hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 30 October 2004 02:22, Mark Fortescue wrote:
> Hi all,
>
> I have been trying to get a CG3 sparc clone up and running with linux.
> Under 2.2.26, the console is fine. During the development of the
> 2.5.x/2.6.x frame buffer system the CG3 support got broken. I have managed
> to track done one of the problems (the blanking code had some typing
> errors in it) and this gave me a logo + black screen and cursor using a
> linux-2.2.8.1 kernel. Still no console text.
>
> Given that 2.2.10-rc1-bk6 is available, I have downloaded and applied the
> appropriate patches and made some additional mods to keep the
> compiler/linker happy. Now I have a black console, no text, logo or cursor
> and if I redirect the console output to a serial port I get the following:

I'm assuming 2.6.10-rc1-bk6...

Make sure you correctly fill up the red, green, blue, and transp fields
in all->info.var.  You can do it in sbufsfb_fill_var, or somewhere
within cg3.c before the register_framebuffer() part.

As a reminder, info->var and info->fix must be valid prior to framebuffer
registration.

Tony




