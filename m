Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261394AbVE3OJP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261394AbVE3OJP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 10:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261601AbVE3OJP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 10:09:15 -0400
Received: from styx.suse.cz ([82.119.242.94]:32919 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S261394AbVE3OJL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 10:09:11 -0400
Date: Mon, 30 May 2005 16:09:02 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: dtor_core@ameritech.net
Cc: Christoph Pleger <Christoph.Pleger@uni-dortmund.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Serial Mouse in Kernel 2.6
Message-ID: <20050530140902.GA1012@ucw.cz>
References: <20050429145248.3551b9ea.Christoph.Pleger@uni-dortmund.de> <d120d5000504290903758bc9f2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d5000504290903758bc9f2@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2005 at 11:03:24AM -0500, Dmitry Torokhov wrote:
> Hi,
> 
> On 4/29/05, Christoph Pleger <Christoph.Pleger@uni-dortmund.de> wrote:
> > Hello,
> > 
> > When configuring Kernel 2.6.11.7, I found under Input Devices two
> > options which seem to have to do with serial mouse support:
> > 
> > 1. Serial line discipline (module serport)
> > 2. Serial Mouse support (module sermouse)
> > 
> > Ic compiled both these features as a module. But after rebooting with
> > the new kernel, the serial mouse is working well with gpm and with X11,
> > although none of the above modules are loaded.
> > 
> > So, what for are the modules mentioned above needed?
> > 
> 
> If you load the modules and use input_attach program to set up your
> mouse then you can access it via /dev/input/mice together with the
> rest of you mice, PS/2, USB, etc. This way you have only one input
> device for you mouse and do not have to change millions of programs
> (actually 2) if you happen to install a new mouse.
> 
> You seem to still using the mouse by accessing /dev/ttySx port and
> using serial mouse driver.
 
You also get a much better update rate for the mouse than with X/GPM, 4x
for MouseSystems, and 2x for Microsoft mice. This makes the serial mouse
finally usable.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
