Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262931AbTGUHB2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 03:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269321AbTGUHAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 03:00:38 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:64941 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S269269AbTGUHAg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 03:00:36 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Mon, 21 Jul 2003 09:28:53 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Greg KH <greg@kroah.com>
Cc: Kernel List <linux-kernel@vger.kernel.org>,
       video4linux list <video4linux-list@redhat.com>
Subject: Re: [RFC/PATCH] sysfs'ify video4linux
Message-ID: <20030721072853.GA21450@bytesex.org>
References: <20030716084448.GC27600@bytesex.org> <20030716161924.GA7406@kroah.com> <20030716202018.GC26510@bytesex.org> <20030716210800.GE2279@kroah.com> <20030717120121.GA15061@bytesex.org> <20030717145749.GA5067@kroah.com> <20030717163715.GA19258@bytesex.org> <20030717214907.GA3255@kroah.com> <20030718095920.GA32558@bytesex.org> <20030718234359.GK1583@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030718234359.GK1583@kroah.com>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hm, it just looks like you quoted my message and didn't write anything
> new.  Did something not go through correctly?

:-/  ... I should learn to use my mailer correctly ...
Should have been that one:

==============================[ cut here ]==============================
To: Greg KH <greg@kroah.com>
Subject: Re: [RFC/PATCH] sysfs'ify video4linux
In-Reply-To: <20030717214907.GA3255@kroah.com>

> > Version (1) can be done without breaking the build, with a hack along 
> > the lines "if (no release callback) printk(KERN_WARN please fix your
> > driver)", so the drivers can be fixed step-by-step afterwards.
> 
> That sounds like a nice way to start.

> I don't think it will be that bad for them.  Just have them change the
> v4l device from being a structure included in their structure, into a
> pointer, and then create it before registering, and free it in the
> release() callback.

Good point.  So the mandatory ->release() callback version is also the
more flexible one.  I like that :)

> Breaking the build is a very good thing to do at times, to ensure that
> stuff gets fixed properly.  Users might go for a while without realizing
> that there really is a problem in their driver.
> 
> But in the end, it's up to you...

Breaking the build _right now_ with 2.6 becoming stable is IMHO not a
good idea, I think I better try to avoid that until 2.7.

New patch will come later today or early next week.

  Gerd

-- 
sigfault

