Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267882AbUJONpS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267882AbUJONpS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 09:45:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267798AbUJONoB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 09:44:01 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:3546 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S267776AbUJONki
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 09:40:38 -0400
X-Envelope-From: kraxel@bytesex.org
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       penguinppc-team@lists.penguinppc.org
Subject: Re: [Linux-fbdev-devel] Generic VESA framebuffer driver and Video card BOOT?
References: <416E6ADC.3007.294DF20D@localhost> <87d5zkqj8h.fsf@bytesex.org>
	<Pine.GSO.4.61.0410151437050.10040@waterleaf.sonytel.be>
From: Gerd Knorr <kraxel@bytesex.org>
Organization: SUSE Labs, Berlin
Date: 15 Oct 2004 15:13:13 +0200
In-Reply-To: <Pine.GSO.4.61.0410151437050.10040@waterleaf.sonytel.be>
Message-ID: <87y8i8p1jq.fsf@bytesex.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> On Fri, 15 Oct 2004, Gerd Knorr wrote:
> > Have you talked to the powermanagement guys btw.?  One of the major
> > issues with suspend-to-ram is to get the graphics card back online,
> > and SNAPBoot might help to fix this too.  I'm not sure a userspace
> > solution would work for *that* through.
> 
> Why not? Of course you won't get any output before the graphics card has been
> re-initialized to a sane and usable state...

You have a application running which uses the framebuffer device, then
suspend with that app running.  You'll have to restore the state of
the device _before_ restarting all the userspace proccesses, otherwise
the app will not be very happy.  I'm not sure if the kernel can run a
userspace helper in that situation (i.e. before waking all the
processes).

  Gerd

-- 
return -ENOSIG;
