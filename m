Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262427AbVCXHmR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262427AbVCXHmR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 02:42:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262731AbVCXHmQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 02:42:16 -0500
Received: from mail6.bluewin.ch ([195.186.4.229]:5338 "EHLO mail6.bluewin.ch")
	by vger.kernel.org with ESMTP id S262427AbVCXHmH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 02:42:07 -0500
Date: Thu, 24 Mar 2005 08:41:09 +0100
From: Roger Luethi <rl@hellgate.ch>
To: Thomas Skora <thomas@skora.net>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] via-rhine.c, wol-bugfix, Kernel 2.6.11.5
Message-ID: <20050324074109.GA14926@k3.hellgate.ch>
References: <87psxp6fq4.fsf@powers.localnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87psxp6fq4.fsf@powers.localnet>
X-Operating-System: Linux 2.6.11 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Mar 2005 01:37:55 +0100, Thomas Skora wrote:
> The via-rhine driver in the actual kernel release 2.6.11.5 resets
> wake-on-lan-settings of the chip. This leads to the fact, that wol is
> disabled after the first reboot. I've attached a little patch, that
> fixes the problem.

This patch won't apply to the 2.6.11.5 I have here -- the driver is
clearing ~0xFC already. The description makes me suspect that the patch
is meant to go the other way, and that would be wrong. Use ethtool if
you want to enable WOL, default in Linux net drivers is off.

Please don't send patches as application/octet-stream, that's
annoying. Send either text/plain or inline.

Roger
