Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284662AbRLUP6P>; Fri, 21 Dec 2001 10:58:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284674AbRLUP5z>; Fri, 21 Dec 2001 10:57:55 -0500
Received: from 12-224-36-149.client.attbi.com ([12.224.36.149]:64018 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S284669AbRLUP5w>;
	Fri, 21 Dec 2001 10:57:52 -0500
Date: Fri, 21 Dec 2001 07:54:09 -0800
From: Greg KH <greg@kroah.com>
To: Wolfgang Weisselberg <eskdyswngvi1s001@sneakemail.com>,
        Karsten Keil <keil@isdn4linux.de>, kkeil@suse.de,
        Kai Germaschewski <kai.germaschewski@gmx.de>,
        linux-kernel@vger.kernel.org
Subject: Re: Kernel Oops in [free_page_and_swap_cache+50/52]
Message-ID: <20011221075409.A20896@kroah.com>
In-Reply-To: <20011221134634.A14357@tiger.bigcats.invalid>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011221134634.A14357@tiger.bigcats.invalid>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Fri, 23 Nov 2001 13:50:14 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2001 at 01:46:34PM +0100, Wolfgang Weisselberg wrote:
> 
> jpilot is a 'palm pilot' connection program (and more), a
> Handspring Visor (a palm-clone) was syncing via it's USB
> connection as the oops happened.  The logfiles say that ISDN
> had disconnected almost exactly a minute before the oops, so
> it was offline.

There is a known bug in the visor driver that can happen when the visor
is done syncing and then disconnects, while the pilot-link connection
(which is what jpilot uses) is still open.  Can you load the visor
driver with "debug=1" and see if this oops still happens (and if so, can
you send me the kernel debug log?)

thanks,

greg k-h
