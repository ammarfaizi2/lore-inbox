Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261634AbULTUsR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261634AbULTUsR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 15:48:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261636AbULTUsQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 15:48:16 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:54163 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261634AbULTUqk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 15:46:40 -0500
Subject: Re: [linux-usb-devel] Re: RFC: [2.6 patch] let BLK_DEV_UB depend
	on EMBEDDED
From: Lee Revell <rlrevell@joe-job.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Ed Tomlinson <edt@aei.ca>, Pete Zaitcev <zaitcev@redhat.com>,
       Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
       "Randy.Dunlap" <rddunlap@osdl.org>, Adrian Bunk <bunk@stusta.de>,
       Greg KH <greg@kroah.com>, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44L0.0412201026390.1358-100000@ida.rowland.org>
References: <Pine.LNX.4.44L0.0412201026390.1358-100000@ida.rowland.org>
Content-Type: text/plain
Date: Mon, 20 Dec 2004 15:46:37 -0500
Message-Id: <1103575597.1252.80.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-12-20 at 10:28 -0500, Alan Stern wrote:
> On Mon, 20 Dec 2004, Ed Tomlinson wrote:
> 
> > Its not that they just enable it.  Its that it has side effects.  I enable it to support
> > one device - it then 'devnaps' other devices that usbstorage supports _much_
> > better.  Is there some way it could work in reverse.  eg. let ub bind only if 
> > usbstorage does not, possibly making usbstorage a _little_ more conservative
> > if ub is present?
> 
> Unfortunately there isn't any way to define which driver should bind to a 
> device, if they are both capable of controlling it.  Maybe there should 
> be.  It might not be too hard to add a sysfs interface for that sort of 
> thing.

This is a neverending battle with ALSA and OSS modules claiming the same
device, resulting in bizarre behavior.  You could argue that it's user
or vendor error but that doesn't change the flood of bug reports on
alsa-user.

I am sure the ALSA developers would welcome a generic solution for this
problem.

Lee

