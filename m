Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031015AbWKPIpH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031015AbWKPIpH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 03:45:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031076AbWKPIpH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 03:45:07 -0500
Received: from wx-out-0506.google.com ([66.249.82.236]:14974 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1031015AbWKPIpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 03:45:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KxZpjKAT04SUj+8TU8T53YPUk/f0JaV2N1lQpc5+smHNkBgeNl32oyb3SRSAGswkaHJGL782VHXQ+H4u17Lo18IkJLhriXRZpJ4aK1XgPSAnihW3CE3qfNE9gfaWyRFyIFo5aFvygzx1NA8RiP15oMsbC56RDxBBftT3yd15Ofc=
Message-ID: <653402b90611160045s6ddf1305jdb262ee55b0f16bf@mail.gmail.com>
Date: Thu, 16 Nov 2006 09:45:03 +0100
From: "Miguel Ojeda" <maxextreme@gmail.com>
To: "James Simmons" <jsimmons@infradead.org>
Subject: Re: ACPI output/lcd/auxdisplay mess
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Linux Fbdev development list" 
	<linux-fbdev-devel@lists.sourceforge.net>,
       "Luming Yu" <Luming.yu@intel.com>, "Andrew Zabolotny" <zap@homelink.ru>
In-Reply-To: <Pine.LNX.4.64.0611150052180.13800@pentafluge.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.64.0611141939050.6957@pentafluge.infradead.org>
	 <653402b90611141426y6db15a3bh8ea59f89c8f1bb39@mail.gmail.com>
	 <Pine.LNX.4.64.0611150052180.13800@pentafluge.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/06, James Simmons <jsimmons@infradead.org> wrote:
>
> > Well, we were aware of video/backlight/* (read below). Anyway,
> > auxdisplay doesn't create a class; it did in first versions, but right
> > now it behaves just like a framebuffer, no classes in the playground
> > (maybe you read a old version?).
> ...
> > However, auxdisplay means "auxiliary display device drivers", not _the
> > display_. In such folder we can put every
> > auxiliar-optional-secundary-rare display (not just LCDs, framebuffers,
> > ...) who has special requirements (like parport wiring, fixed refresh
> > rate, different properties...). Also, things like "set_contrast",
> > "max_constrast", "set_power"... didn't seem very appropriate.
>
> Is it a framebuffer device ? The framebuffer layer is abstracted to work
> with such devices.
>

cfag12864bcfb is a "fbdev" (actually, it is a "fb wrapper" for
cfag12864b, so it behaves like a framebuffer, although it is not an
usual framebuffer. f.e. it has asynchronous refresh rate, a mmaped
page to appear to be a fb...).

Still, it is not the front panel lcd of any specific device like PDA,
so people that expects only their primary video/ displays may be
confused if it appears at such section. So we decided to go away from
video/. Maybe we can change the description, as right now it only
refers to front panel lcds.

-- 
Miguel Ojeda
http://maxextreme.googlepages.com/index.htm
