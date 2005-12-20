Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932075AbVLTURW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932075AbVLTURW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 15:17:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932076AbVLTURW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 15:17:22 -0500
Received: from dsl081-060-252.sfo1.dsl.speakeasy.net ([64.81.60.252]:42880
	"EHLO vitelus.com") by vger.kernel.org with ESMTP id S932075AbVLTURV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 15:17:21 -0500
Date: Tue, 20 Dec 2005 12:17:19 -0800
From: Aaron Lehmann <aaronl@vitelus.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Promise SATA oops
Message-ID: <20051220201719.GC15466@vitelus.com>
References: <20051202045853.GD3677@vitelus.com> <438FDB9D.2030201@pobox.com> <20051202195109.GE3677@vitelus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051202195109.GE3677@vitelus.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2005 at 11:51:09AM -0800, Aaron Lehmann wrote:
> Still isn't stable. It froze within hours after announcing in all
> terminals that it was disabling a certain IRQ. Now the RAID is so
> degraded that root can't even be mounted. Was the Promise controller a
> bad choice for a reliable setup?
> 
> I may not have time to look at this further until late next week, but
> I'll follow up with whatever I learn.

Argh, died again!! It had been stable for over 12 days. Same error
message, and the root md is degraded and dirty just like last time.
This is a very severe state with high risk of data loss. When things
went sour, terminals and most applications still kept working, but
anything that touched the filesystem froze up. I had a shell open in a
chroot on a ramdisk, but dmesg just hung for a few minutes and then
exited with a "Bus error". I had no other way of examining the kernel
log since the machine runs X.

This was running 2.6.15-rc4. Crashes seem to happen less frequently
with it than with 2.6.14.x, but when they happen they leave the RAID
in a severe state. I also don't think 2.6.14.2 said anything about
disabling the IRQ.

I'm very desperate now. About every week I experience a crash that
damages my RAID array to the point where it can't boot, as if the
instability wasn't bad enough. Do I need to buy a hardware RAID card?
