Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751438AbWAWNRP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751438AbWAWNRP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 08:17:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751446AbWAWNRP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 08:17:15 -0500
Received: from mail.shareable.org ([81.29.64.88]:50824 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S1751438AbWAWNRO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 08:17:14 -0500
Date: Mon, 23 Jan 2006 13:17:07 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Chase Venters <chase.venters@clientec.com>
Cc: Michael Loftis <mloftis@wgops.com>, "Barry K. Nathan" <barryn@pobox.com>,
       Al Boldi <a1426z@gawab.com>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] VM: I have a dream...
Message-ID: <20060123131707.GA20163@mail.shareable.org>
References: <200601212108.41269.a1426z@gawab.com> <986ed62e0601221155x6a57e353vf14db02cc219c09@mail.gmail.com> <E3C35184F807ADEC2AD9E182@dhcp-2-206.wgops.com> <200601222346.24781.chase.venters@clientec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601222346.24781.chase.venters@clientec.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chase Venters wrote:
> Just as a curiosity... does anyone have any guesses as to the
> runtime performance cost of hosting one or more swap files (which
> thanks to on demand creation and growth are presumably built of
> blocks scattered around the disk) versus having one or more simple
> contiguous swap partitions?

> I think it's probably a given that swap partitions are better; I'm just 
> curious how much better they might actually be.

When programs must access files in addition to swapping, and that
includes demand-paged executable files, swap files have the
_potential_ to be faster because they provide opportunities to use the
disk nearer the files which are being accessed.  This is more so is
all the filesystem's free space is available for swapping.  A swap
partition in this scenario forces the disk head to move back and forth
between the swap partition and the filesystem.

-- Jamie
