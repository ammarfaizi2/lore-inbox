Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932530AbVLMHed@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932530AbVLMHed (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 02:34:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932542AbVLMHed
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 02:34:33 -0500
Received: from styx.suse.cz ([82.119.242.94]:61122 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S932537AbVLMHec (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 02:34:32 -0500
Date: Tue, 13 Dec 2005 08:34:23 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Mouse button swapping
Message-ID: <20051213073423.GA7784@midnight.suse.cz>
References: <Pine.LNX.4.61.0512091508250.8080@yvahk01.tjqt.qr> <200512130108.29822.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512130108.29822.dtor_core@ameritech.net>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2005 at 01:08:28AM -0500, Dmitry Torokhov wrote:
> On Friday 09 December 2005 09:10, Jan Engelhardt wrote:
> > Hi,
> > 
> > 
> > I produced a small patch that allows one to flip the mouse buttons at the 
> > kernel level. This is useful for changing it on a per-system basis, i.e. it 
> > will affect gpm, X and VMware all at once. It is changeable through
> > /sys/module/mousedev/swap_buttons at runtime. Is this something mainline would
> > be interested in?
> 
> I am not sure if this should be done in kernel. It will also not work for mouse
> drivers using event interface (which hopefully will be default someday) instead
> of legacy mousedev interface.
 
It shouldn't be done by the kernel. Perhaps a shared configuration, but
the same way keymaps aren't handled by the kernel for the applications,
mouse button remapping shouldn't be there.

On the other hand, we have button remapping in joydev, to support old
applications that can't handle it themselves. By the same logic, it
could be in mousedev, to support remapping of buttons on applications
(older vmware), where there is no way to change it.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
