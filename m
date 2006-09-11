Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964912AbWIKQBb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964912AbWIKQBb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 12:01:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964947AbWIKQBb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 12:01:31 -0400
Received: from natsmtp00.rzone.de ([81.169.145.165]:13985 "EHLO
	natsmtp00.rzone.de") by vger.kernel.org with ESMTP id S964912AbWIKQBa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 12:01:30 -0400
Date: Mon, 11 Sep 2006 17:52:39 +0200
From: Olaf Hering <olaf@aepfle.de>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       Daniel Quinlan <quinlan@pathname.com>, Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH] Prevent legacy io access on pmac
Message-ID: <20060911155239.GA25534@aepfle.de>
References: <20060911115354.GA23884@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20060911115354.GA23884@aepfle.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, Olaf Hering wrote:

> 
> The ppc32 common config runs also on PReP/CHRP, which uses PC style IO
> devices.  The probing is bogus, it crashes or floods dmesg.
> 
> ppc can boot one single binary on prep, chrp and pmac boards.
> ppc64 can boot one single binary on pseries and G5 boards.
> pmac has no legacy io, probing for PC style legacy hardware leads to a
> hard crash:

drivers/input/touchscreen/mk712.c pokes at 0x262 and other IO ports.
A comment in the driver suggests that it is only used on Gateway
computers. Should the driver be X86 only?
