Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262064AbVCDFkP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262064AbVCDFkP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 00:40:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261582AbVCDFkO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 00:40:14 -0500
Received: from waste.org ([216.27.176.166]:51691 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262064AbVCDFiv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 00:38:51 -0500
Date: Thu, 3 Mar 2005 21:38:50 -0800
From: Matt Mackall <mpm@selenic.com>
To: Alexander Gran <alex@zodiac.dnsalias.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc5-mm1: reiser4 panic
Message-ID: <20050304053849.GP3163@waste.org>
References: <200503040216.56889@zodiac.zodiac.dnsalias.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503040216.56889@zodiac.zodiac.dnsalias.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2005 at 02:16:56AM +0100, Alexander Gran wrote:
> Hi,
> 
> after my external USB hdd disconnected itself reiser4 paniced. I dont think a 
> journalingfs should panic if its device fails..

Panicking is sometimes what you want. Panic can trigger a reboot and
get the box back on its feet quickly.

But going read-only on errors is a more sensible default policy,
especially if you have other unrelated activities going on.
Ext2 and ext3 have such an option.

-- 
Mathematics is the supreme nostalgia of our time.
