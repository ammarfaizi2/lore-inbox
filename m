Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932375AbWIQThG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932375AbWIQThG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 15:37:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932376AbWIQThG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 15:37:06 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:58240 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932375AbWIQThF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 15:37:05 -0400
Date: Sun, 17 Sep 2006 21:36:59 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: kernel list <linux-kernel@vger.kernel.org>, maxk@qualcomm.com,
       bluez-devel@lists.sourceforge.net
Subject: Re: bluetooth oops during resume from ram
Message-ID: <20060917193659.GB2973@elf.ucw.cz>
References: <20060917140952.GA3349@elf.ucw.cz> <1158511979.24941.1.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1158511979.24941.1.camel@localhost>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 2006-09-17 18:52:59, Marcel Holtmann wrote:
> Hi Pavel,
> 
> > If I suspend-to-RAM with usb active on thinkpad x60, I get an
> > oops. Machine works okay after that, but...
> > 
> > it seems bluetooth is scribbling over more memory than was allocated
> > (?)
> 
> not that I am aware of. Is this a plain 2.6.18-rc6 or did you apply
> additional patches that might have caused this behavior?

I have some additional changes, but they should not affect this...

OTOH, I probably used this script:


killall hciattach
sleep .1
setserial /dev/ttyBT baud_base 921600
hciattach -s 921600 /dev/ttyS0 bcsp
hciconfig hci0 up
hciconfig hci0 name billionton
hciconfig /dev/ttyUB1

...even through there's no bluetooth at ttyS0 (as this machine has
bluetooth on usb).
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
