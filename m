Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266983AbUBGRV5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 12:21:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266986AbUBGRV5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 12:21:57 -0500
Received: from smtp.everyone.net ([216.200.145.17]:1262 "EHLO
	rmta04.mta.everyone.net") by vger.kernel.org with ESMTP
	id S266983AbUBGRVz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 12:21:55 -0500
Date: Sat, 7 Feb 2004 12:21:52 -0500
From: "Kevin O'Connor" <kevin@koconnor.net>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.3-rc1
Message-ID: <20040207172152.GA6412@arizona.localdomain>
References: <Pine.LNX.4.58.0402061823040.30672@home.osdl.org> <20040207025638.GW21151@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040207025638.GW21151@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 07, 2004 at 02:56:38AM +0000, viro@parcelfarce.linux.theplanet.co.uk wrote:
> One note: please, please, let's put a moratorium on sysfs-related patches
> that didn't go through review.  We are just getting netdev situation in
> the main tree under control.  It took nearly half a year (if not more).
[...]
> If you are doing any sysfs integration - *fix* *lifetime* *rules* *first*.

There appears to be a lot of developer activity concentrated on getting
sysfs support in various parts of the kernel, and this inevitably leads to
a reworking of kernel object lifetime rules.  I have to wonder if making
these lifetime changes is really a good idea.

Sysfs appears to be mainly used for exporting various adhoc pieces of
information and occasionally for getting various tuning input.  This
functionality is generally ancillary to the main purpose of the
subsystems/drivers that use sysfs.  It seems backward to me that the
lifetime rules of an object should be dominated by this ancillary
functionality.

So, my question - is it really a good idea to rework much of the kernel
object lifetime rules just to support sysfs?

And a related question - couldn't sysfs be taught to atomically drop its
references to external kernel objects and thus obviate the need for all
these lifetime rule changes?

-Kevin

-- 
 ---------------------------------------------------------------------
 | Kevin O'Connor                  "BTW, IMHO we need a FAQ for      |
 | kevin@koconnor.net               'IMHO', 'FAQ', 'BTW', etc. !"    |
 ---------------------------------------------------------------------
