Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261239AbULTMEm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbULTMEm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 07:04:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261256AbULTMEm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 07:04:42 -0500
Received: from mail.aei.ca ([206.123.6.14]:51198 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S261239AbULTMEl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 07:04:41 -0500
From: Ed Tomlinson <edt@aei.ca>
Organization: me
To: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: RFC: [2.6 patch] let BLK_DEV_UB depend on EMBEDDED
Date: Mon, 20 Dec 2004 07:02:48 -0500
User-Agent: KMail/1.7.1
Cc: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
       "Randy.Dunlap" <rddunlap@osdl.org>, Adrian Bunk <bunk@stusta.de>,
       Greg KH <greg@kroah.com>, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
References: <20041220001644.GI21288@stusta.de> <20041220062055.GA22120@one-eyed-alien.net> <20041219223723.3e861fc5@lembas.zaitcev.lan>
In-Reply-To: <20041219223723.3e861fc5@lembas.zaitcev.lan>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412200702.50071.edt@aei.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 20 December 2004 01:37, Pete Zaitcev wrote:
> On Sun, 19 Dec 2004 22:20:55 -0800, Matthew Dharm <mdharm-kernel@one-eyed-alien.net> wrote:
> 
> > I can tell you that this has turned into the single largest source of bug
> > reports/complaints about usb-storage.  Something has to be done.  I just
> > don't know what.
> 
> Is it that bad, really? Honestly, I could not imagine users can be so dumb.
> The option defaults to off. There is a warning in the Kconfig. And yet they
> first enable it and then complain about it. I don't know what to do about
> it, either.

Its not that they just enable it.  Its that it has side effects.  I enable it to support
one device - it then 'devnaps' other devices that usbstorage supports _much_
better.  Is there some way it could work in reverse.  eg. let ub bind only if 
usbstorage does not, possibly making usbstorage a _little_ more conservative
if ub is present?

Ed Tomlinson
