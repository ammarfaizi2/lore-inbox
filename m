Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751043AbWE1XNw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751043AbWE1XNw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 19:13:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751042AbWE1XNw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 19:13:52 -0400
Received: from wr-out-0506.google.com ([64.233.184.229]:23738 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751041AbWE1XNv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 19:13:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ujkIlGNtRfgAwwHHJUcNdRsaBh/XFg2WRi+sMfHhanXXN9TutjZc1LlLi1PUASqATglaC5s5SWpKweGEPKJ3HKHmmkTTUE2hKx1rxq0694Htm/Ttl6gD2OUovQuaN7RLdZPNE73kr6xuRGT8ehtpp8xNy8SP04gB9R6dP8oI7Xs=
Message-ID: <21d7e9970605281613y3c44095bu116a84a66f5ba1d7@mail.gmail.com>
Date: Mon, 29 May 2006 09:13:50 +1000
From: "Dave Airlie" <airlied@gmail.com>
To: "D. Hazelton" <dhazelton@enter.net>
Subject: Re: OpenGL-based framebuffer concepts
Cc: "Jon Smirl" <jonsmirl@gmail.com>, "Pavel Machek" <pavel@ucw.cz>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Kyle Moffett" <mrmacman_g4@mac.com>,
       "Manu Abraham" <abraham.manu@gmail.com>,
       "linux cbon" <linuxcbon@yahoo.fr>,
       "Helge Hafting" <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
In-Reply-To: <200605280112.01639.dhazelton@enter.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>
	 <200605272245.22320.dhazelton@enter.net>
	 <9e4733910605272027o7b59ea5n5d402dabdd7167cb@mail.gmail.com>
	 <200605280112.01639.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > For a specific DRM chip there are currently four modules:
> > fbdev-core
> > fbdev-chip depends on fbdev-core
> > drm-core
> > drm-chip depends on drm-core
> > RIght now drm and fbdev can be loaded independently.
> >
> > I would always keep fbdev-core and drm-core as separate modules.  But
> > drm-core may become dependent on fbdev-core.

I've already pointed out to Jon the problems with this approach on
numerous occasions and to be honest do not have the time to do so
again,

I will not accept patches to make DRM drivers rely on fbdev drivers in
the kernel for many many many reasons, two quick ones :

a) we don't always have a fully functional fbdev driver, see intel fb drivers.
b) loading fbdev drivers breaks X in a lot of cases, we need to be a
bit more careful.
c) Lots of distros don't use fbdev drivers, forcing this on them to
use drm isn't an option.

should I go on?

I've made suggestions I've given you patches that start the work, I'm
going to finish that work, but I've no timeline, I'd hope at KS/OLS
this year to do it..

Dave.
