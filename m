Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265526AbUAGN1B (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 08:27:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265527AbUAGN1B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 08:27:01 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36494 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265526AbUAGN1A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 08:27:00 -0500
Date: Wed, 7 Jan 2004 13:26:56 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Olaf Hering <olh@suse.de>
Cc: Rob Love <rml@ximian.com>, Nathan Conrad <lk@bungled.net>,
       Pascal Schmidt <der.eremit@email.de>, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>
Subject: Re: udev and devfs - The final word
Message-ID: <20040107132656.GM4176@parcelfarce.linux.theplanet.co.uk>
References: <18Cz7-7Ep-7@gated-at.bofh.it> <E1AbWgJ-0000aT-00@neptune.local> <20031231192306.GG25389@kroah.com> <1072901961.11003.14.camel@fur> <20031231220107.GC11032@bungled.net> <1072909218.11003.24.camel@fur> <20031231225536.GP4176@parcelfarce.linux.theplanet.co.uk> <20040107101559.GA22770@suse.de> <20040107111832.GL4176@parcelfarce.linux.theplanet.co.uk> <20040107130036.GA3186@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040107130036.GA3186@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 07, 2004 at 02:00:36PM +0100, Olaf Hering wrote:
 
> Ok, it was mkfs.minix and an older distro.

mkfs should simply pass O_EXCL to open().  Which is what you really want
and yes, it should work on 2.6 (not sure if it got backported on 2.4).
