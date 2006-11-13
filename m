Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753787AbWKMBrJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753787AbWKMBrJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 20:47:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753788AbWKMBrJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 20:47:09 -0500
Received: from alnrmhc13.comcast.net ([204.127.225.93]:30368 "EHLO
	alnrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S1753787AbWKMBrG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 20:47:06 -0500
Subject: Re: [RFC] Pushing device/driver binding decisions to userspace
From: Nicholas Miell <nmiell@comcast.net>
To: Ben Collins <ben.collins@ubuntu.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1163381067.5178.301.camel@gullible>
References: <1163374762.5178.285.camel@gullible>
	 <1163378981.2801.3.camel@entropy>  <1163381067.5178.301.camel@gullible>
Content-Type: text/plain
Date: Sun, 12 Nov 2006 17:47:05 -0800
Message-Id: <1163382425.2801.6.camel@entropy>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.0.njm.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-11-12 at 17:24 -0800, Ben Collins wrote:
> On Sun, 2006-11-12 at 16:49 -0800, Nicholas Miell wrote:
> > On Sun, 2006-11-12 at 15:39 -0800, Ben Collins wrote:
> > 
> > What's wrong with making udev or whatever unbind driver A and then bind
> > driver B if the driver bound by the kernel ends up being the wrong
> > choice? (Besides the inelegance of the kernel choosing one and then
> > userspace immediately choosing the other, of course.)
> > 
> > I'd argue that having multiple drivers for the same hardware is a bit
> > strange to begin with, but that's another issue entirely.
> 
> If two drivers are loaded for the same device, there's no way for udev
> to tell the kernel which driver to use for a device, that I know of.

/sys/bus/*/drivers/*/{bind,unbind}

> Also, that just sounds very horrible to do. If you have udev/dbus events
> flying around for "device present", "device gone", "device present",
> then it could make for a very ugly user experience (think of programs to
> handle devices being started because of these events).

So don't fire the events until after the final binding.

-- 
Nicholas Miell <nmiell@comcast.net>

