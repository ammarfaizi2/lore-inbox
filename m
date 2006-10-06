Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932075AbWJFLVQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932075AbWJFLVQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 07:21:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932089AbWJFLVQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 07:21:16 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:18833 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932075AbWJFLVP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 07:21:15 -0400
Date: Fri, 6 Oct 2006 13:21:05 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Oliver Neukum <oliver@neukum.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] error to be returned while suspended
Message-ID: <20061006112105.GI29353@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0610051219500.6596-100000@iolanthe.rowland.org> <200610051835.21704.oliver@neukum.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200610051835.21704.oliver@neukum.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2006-10-05 18:35:21, Oliver Neukum wrote:
> Am Donnerstag, 5. Oktober 2006 18:21 schrieb Alan Stern:
> > Currently we don't have any userspace APIs for such a daemon to use.  The 
> > only existing API is deprecated and will go away soon.
> 
> I trust it'll be replaced.

It does not seem that API was that useful after all.

> > Current thinking is that a driver will suspend its device whenever the 
> > device isn't in use.  With usblp, that would be whenever the device file 
> > isn't open.  See the example code in usb-skeleton.c.
> 
> In the general case the idea seems insufficient. If I close my laptop's lid
> I want all input devices suspended, whether the corresponding files are
> opened or not. In fact, if I have port level power control I might even
> want to cut power to them.

I do not see how this is useful.
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
