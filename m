Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261873AbTHTKrT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 06:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261878AbTHTKrT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 06:47:19 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:29389 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S261873AbTHTKrS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 06:47:18 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16195.20914.632136.929876@gargle.gargle.HOWL>
Date: Wed, 20 Aug 2003 12:47:14 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Andi Kleen <ak@suse.de>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org,
       venkatesh.pallipadi@intel.com
Subject: Re: [PATCH][2.6][2/5]Support for HPET based timer
In-Reply-To: <p731xvg7imu.fsf@oldwotan.suse.de>
References: <C8C38546F90ABF408A5961FC01FDBF1902C7D1C9@fmsmsx405.fm.intel.com.suse.lists.linux.kernel>
	<20030820080513.GB17793@ucw.cz.suse.lists.linux.kernel>
	<p731xvg7imu.fsf@oldwotan.suse.de>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen writes:
 > Vojtech Pavlik <vojtech@suse.cz> writes:
 > 
 > > On Tue, Aug 19, 2003 at 05:18:50PM -0700, Pallipadi, Venkatesh wrote:
 > > 
 > > > Fixmap is for HPET memory map address access. As the timer
 > > > initialization happen 
 > > > early in the boot sequence (before vm initialization), we need to have
 > > > fixmap() 
 > > > and fix_to_virt() to access HPET memory map address.
 > > 
 > > Ahh, yes, you're right. You can't use ioremap at that time. Actually I
 > > did the same on x86_64 not only because of vsyscalls.
 > 
 > iirc i386 has an ioremap_early or somesuch.

bt_ioremap(). I wrote it to support early DMI scan so DMI data
could be used to blacklist BIOSen that break local APICs.
This was done pretty much just to handle Dell laptops.
