Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751134AbVH1LA1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbVH1LA1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Aug 2005 07:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbVH1LA1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Aug 2005 07:00:27 -0400
Received: from rproxy.gmail.com ([64.233.170.195]:57671 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751134AbVH1LA1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Aug 2005 07:00:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UfwZwYVs8AzhGLrs/DT+kVXrHP9QSveOu48tzXns5XLQlgwUndXeQHwOAnQ+vba13PWfsVFnaa1ZCErp4g6q4oHINRaTG28HBY4O5n0hZpgVOltgckDGHGxZt+8tgiobUxXRRHQC+wTz/RVVua8qjptCo7V97rm5bUbtVXe8iyc=
Message-ID: <25381867050828040065312bf5@mail.gmail.com>
Date: Sun, 28 Aug 2005 07:00:24 -0400
From: Yani Ioannou <yani.ioannou@gmail.com>
To: dtor_core@ameritech.net
Subject: Re: [patch] IBM HDAPS accelerometer driver.
Cc: Robert Love <rml@novell.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <d120d50005082613122595cde8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1125069494.18155.27.camel@betsy>
	 <d120d500050826122768cd3612@mail.gmail.com>
	 <1125085141.18155.97.camel@betsy>
	 <d120d50005082613122595cde8@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/26/05, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> On 8/26/05, Robert Love <rml@novell.com> wrote:
> > On Fri, 2005-08-26 at 14:27 -0500, Dmitry Torokhov wrote:
> >
> > > What this completion is used for? I don't see any other references to it.
> >
> > It was the start of the release() routine, but I decided to move to
> > platform_device_register_simple() and use its release, instead.  So this
> > is gone now in my tree.
> >
> > > I'd rather you used absolute coordinates and set up
> > > hdaps_idev->absfuzz to do the filtering.
> >
> > Me too.
> >
> 
> Btw, if you set up absolute input device it will be claimed by joydev
> instead of mousedev and will not get in a way of normal operation
> while still available for playing. So you could just kill all that
> enabling/disabling code and have input device always activated.

Even easier - I submitted a patch a while back against the old hdaps
driver (on hdaps-devel) to use the hdaps sensor's keyboard/mouse
activity readings to selectively disable/enable the mouse (and
re-enable it after a time of no keyboard/mouse activity). This makes
the mouse device much more usable, and you don't end up fighting it
while trying to use the normal mouse/keyboard.

Yani
