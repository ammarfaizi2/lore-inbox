Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270515AbTHGUP7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 16:15:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270519AbTHGUP6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 16:15:58 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:31237 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S270515AbTHGUP4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 16:15:56 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Ken Moffat <ken@kenmoffat.uklinux.net>, marcelo@conectiva.com.br
Subject: Re: 2.4.22-rc1 breaks dri in X-4.3.0
Date: Thu, 7 Aug 2003 22:15:33 +0200
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.56.0308072050120.9400@ppg_penguin>
In-Reply-To: <Pine.LNX.4.56.0308072050120.9400@ppg_penguin>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308072215.33253.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 07 August 2003 22:01, Ken Moffat wrote:

Hi Ken,

>  I've just built 2.4.22-rc1 for my PIII (via chipset, radeon 7500), and
> rebuilt radeon.o from the X 4.3 release.  This combination worked with
> 2.4.22-pre7 (although with occasional X lock-ups).

could you please try the DRI sources from XFree cvs repo and see if it makes 
any difference? (I'll bet it will)

>  In X's log I can see that the radeon module fails to open
> /dev/dri/card0 (no such device) and therefore the module load fails.

Sounds like radeon.i isn't loaded.

>  From dmesg I can see that agpgart detects the chipset and reports the
> aperture,  but there are zero [drm] messages following.
> My .config shows
> CONFIG_DRM=y
> CONFIG_DRM_NEW=y
> CONFIG_DRM_RADEON=m

do you have radeon.o loaded? "lsmod|grep radeon"

What does dmesg say if it should autoloads the module when you start X? 
(assuming you have autoload support enabled)

ciao, Marc


