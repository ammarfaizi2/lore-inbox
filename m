Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422771AbWA1BF0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422771AbWA1BF0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 20:05:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422773AbWA1BF0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 20:05:26 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:23305 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S1422771AbWA1BFZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 20:05:25 -0500
Date: Sat, 28 Jan 2006 02:05:25 +0100
From: Olivier Galibert <galibert@pobox.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Suspend to RAM: help with whitelist wanted
Message-ID: <20060128010524.GA59822@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
References: <20060126213611.GA1668@elf.ucw.cz> <20060127170406.GA6164@dreamland.darkstar.lan> <20060127230535.GA1617@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060127230535.GA1617@elf.ucw.cz>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 28, 2006 at 12:05:35AM +0100, Pavel Machek wrote:
> I originally wanted to avoid calling external problems. That way,
> s2ram code could be pagelocked and you would get your video back even
> in case of disk problems etc.

You should not add yet another program that does video card accesses
from userspace.  The xorg and fbdev developpers are having a hard
enough time already making sure both sides have a consistent view of
the video card state, and it looks like they're on the way to unifying
as much as they can in the kernel under drm just because of these
difficulties.  Do not add to them by frobbing the card in
unpredictable ways from userspace, please.

  OG.
