Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751026AbWHIPi2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751026AbWHIPi2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 11:38:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751032AbWHIPi2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 11:38:28 -0400
Received: from free.wgops.com ([69.51.116.66]:28691 "EHLO shell.wgops.com")
	by vger.kernel.org with ESMTP id S1751026AbWHIPi1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 11:38:27 -0400
Date: Wed, 09 Aug 2006 09:38:21 -0600
From: Michael Loftis <mloftis@wgops.com>
To: Molle Bestefich <molle.bestefich@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: ext3 corruption
Message-ID: <1A5F0A2F95110B3F35E8A9B5@dhcp-2-206.wgops.com>
In-Reply-To: <62b0912f0608090822n2d0c44c4uc33b5b1db00e9d33@mail.gmail.com>
References: <62b0912f0607131332u5c390acfrd290e2129b97d7d9@mail.gmail.com>	
 <62b0912f0608081647p2d540f43t84767837ba523dc4@mail.gmail.com>	
 <Pine.LNX.4.61.0608090723520.30551@chaos.analogic.com>
 <62b0912f0608090822n2d0c44c4uc33b5b1db00e9d33@mail.gmail.com>
X-Mailer: Mulberry/4.0.4 (Mac OS X)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-MailScanner-Information: Please contact support@wgops.com
X-MailScanner: WGOPS clean
X-MailScanner-From: mloftis@wgops.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On August 9, 2006 5:22:28 PM +0200 Molle Bestefich 
<molle.bestefich@gmail.com> wrote:


> Messages on the console indicated that Linux actually tried to
> shutdown the filesystem before shutting down Samba, which is just
> plain Real-F......-Stupid.  Is there no intelligent ordering of
> shutdown events in Linux at all?

The kernel doesn't perform those, your distro's init scripts do that.  And 
various distros have various success at doing the right thing.  I've had 
the best luck with Debian and Ubuntu doing this in the right order.  RH 
seems to insist on turning off the network then network services such as 
sshd.

> Samba was serving files to remote computers and had no desire to let
> go of the filesystem while still running.  After 5 seconds or so,
> Linux just shutdown the MD device with the filesystem still mounted.

The kernel probably didn't do this, usually by the time the kernel gets to 
this point init has already sent kills to everything.  If it hasn't it 
points to problems with your init scripts, not the kernel.

>
> That's what happened on a user-visible level, but what could have
> happened internally in the filesystem?


