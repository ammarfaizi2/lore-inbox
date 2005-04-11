Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261850AbVDKQuy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261850AbVDKQuy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 12:50:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261839AbVDKQtB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 12:49:01 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:2474 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261837AbVDKQj7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 12:39:59 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Oliver Neukum <oliver@neukum.org>
Subject: Re: [PATCH] zero disk pages used by swsusp on resume
Date: Mon, 11 Apr 2005 18:39:50 +0200
User-Agent: KMail/1.7.1
Cc: Pavel Machek <pavel@ucw.cz>, Andreas Steinmetz <ast@domdv.de>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
References: <42592697.8060909@domdv.de> <20050410201455.GA21568@elf.ucw.cz> <200504111237.45452.oliver@neukum.org>
In-Reply-To: <200504111237.45452.oliver@neukum.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504111839.50872.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Monday, 11 of April 2005 12:37, Oliver Neukum wrote:
> Am Sonntag, 10. April 2005 22:14 schrieb Pavel Machek:
> > Hi!
> > 
> > > > Oliver Neukum wrote:
> > > > > What is the point in doing so after they've rested on the disk for ages?
> > > > 
> > > > The point is not physical access to the disk but data gathering after
> > > > resume or reboot.
> > > 
> > > After resume or reboot normal access control mechanisms will work
> > > again. Those who can read a swap partition under normal circumstances
> > > can also read /dev/kmem. It seems to me like you are putting an extra
> > > lock on a window on the third floor while leaving the front door open.
> > 
> > Andreas is right, his patches are needed.
> > 
> > Currently, if your laptop is stolen after resume, they can still data
> > in swsusp image.
> > 
> > Zeroing the swsusp pages helps a lot here, because at least they are
> > not getting swsusp image data without heavy tools. [Or think root
> > compromise month after you used swsusp.]
> > 
> > Encrypting swsusp image is of course even better, because you don't
> > have to write large ammounts of zeros to your disks during resume ;-).
> 
> Not only is it better, it completely supercedes wiping the image.
> Your laptop being stolen after resume is very much a corner case.
> You suspend your laptop while you are not around, don't you?

Not necessarily.  Some people use suspend instead of shutdown. :-)

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
