Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261758AbVDUSpU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261758AbVDUSpU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 14:45:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261778AbVDUSpT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 14:45:19 -0400
Received: from open.hands.com ([195.224.53.39]:60312 "EHLO open.hands.com")
	by vger.kernel.org with ESMTP id S261758AbVDUSoT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 14:44:19 -0400
Date: Thu, 21 Apr 2005 19:53:25 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: linux-kernel@vger.kernel.org,
       Linux ARM Kernel list 
	<linux-arm-kernel@lists.arm.linux.org.uk>
Subject: Re: [2.6.11.7 / CLPS711x/SkyMinder] module integration issue: keyboard driver _still_ not working after port from 2.4.27
Message-ID: <20050421185325.GB16160@lkcl.net>
References: <20050421182845.GA16160@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050421182845.GA16160@lkcl.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

okay - i found this:

	http://seclists.org/lists/linux-kernel/2000/Mar/0093.html

it talks about "we must force people to choose between vgacon and
fbcon".

when that forcing decision was taken, was dual fbcon-and-serial-console
usage taken into account?

booting with ..... console=ttyCL1 fbcon=vc:1 and then later
on doing modprobe fbcon has exactly the same consequences:
fbcon_takeover is called, the fbcon=vc:1 parameters appear to
be ignored.... greeeeaat.

how the _heck_ am i gonna over-ride the fb_console "setup"
paramaters on a module load, to stop this happening???

i know - HACK TIME!!!

muhahahahah.

l.


On Thu, Apr 21, 2005 at 07:28:45PM +0100, Luke Kenneth Casson Leighton wrote:

> in order to be able to debug what is going on, i have enabled 
> a dummy/virtual serial console, all is well so far.
> 
> in order to test the screen, i have written, enabled, tested,
> confirmed as reasonably working, a framebuffer driver (which
> i would like to make the console framebuffer - eventually -
> when the serial console is disabled and no longer needed -
> so i am enabling Framebuffer Console support AS WELL as serial
> console support)
> 
> now i load the keyboard event module... splat - absolutely no response:
> complete lock-up.

