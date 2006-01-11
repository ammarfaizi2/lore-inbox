Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750714AbWAKVVF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbWAKVVF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 16:21:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750729AbWAKVVF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 16:21:05 -0500
Received: from hansmi.home.forkbomb.ch ([213.144.146.165]:5661 "EHLO
	hansmi.home.forkbomb.ch") by vger.kernel.org with ESMTP
	id S1750714AbWAKVVE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 16:21:04 -0500
Date: Wed, 11 Jan 2006 22:20:56 +0100
From: Michael Hanselmann <linux-kernel@hansmi.ch>
To: dtor_core@ameritech.net
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linux-kernel@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz,
       linuxppc-dev@ozlabs.org, linux-kernel@killerfox.forkbomb.ch,
       Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH/RFC?] usb/input: Add support for fn key on Apple PowerBooks
Message-ID: <20060111212056.GC6617@hansmi.ch>
References: <20051225212041.GA6094@hansmi.ch> <200512252304.32830.dtor_core@ameritech.net> <1135575997.14160.4.camel@localhost.localdomain> <d120d5000601111307x451db79aqf88725e7ecec79d2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d5000601111307x451db79aqf88725e7ecec79d2@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2006 at 04:07:37PM -0500, Dmitry Torokhov wrote:
> Ok, I am looking at the patch again, and I have a question - do we
> really need these 3 module parameters? If the goal is to be compatible
> with older keyboards then shouldn't we stick to one behavior?

The old keyboard was controlled by ADB (Apple Desktop Bus) commands sent
by pbbuttonsd. That doesn't work for the USB keyboard because the
conversion is not done in hardware like with the old ones. ioctl's would
also be possible, but I'm not sure wether they would be easy to do for
USB devices. Module parameters can be changed using sysfs.

Greets,
Michael
