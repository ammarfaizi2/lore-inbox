Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261989AbVCUV2A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261989AbVCUV2A (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 16:28:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261990AbVCUV1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 16:27:48 -0500
Received: from isilmar.linta.de ([213.239.214.66]:5841 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S261903AbVCUV0z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 16:26:55 -0500
Date: Mon, 21 Mar 2005 22:26:54 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Andrew Morton <akpm@osdl.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: PCMCIA bugs in buglist [Was: Re: 2.6.12-rc1-mm1]
Message-ID: <20050321212654.GA16368@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Andrew Morton <akpm@osdl.org>,
	Russell King <rmk+lkml@arm.linux.org.uk>,
	linux-kernel@vger.kernel.org
References: <20050321025159.1cabd62e.akpm@osdl.org> <20050321202022.B16069@flint.arm.linux.org.uk> <20050321124159.0fbf1bef.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050321124159.0fbf1bef.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Sebastian =?iso-8859-1?q?K=FCgler?= <lists@vizZzion.org>
> Subject: PCMCIA breaks suspend-to-(disk|ram) with 2.6.11

Fixed by upgrading the userspace script used by him to include

	"cardctl eject && sleep 1"

before killing cardmgr, as killing cardmgr no longer auto-detaches PCMCIA
devices and this was what he needs: while suspend/resume does work with 
PCMCIA in general AFAIK, certain device drivers are faulty.

> From: Ron Gage <ron@rongage.org>
> Subject: Major problem with PCMCIA/Yenta system
...
> From: Jonas Oreland <jonas.oreland@mysql.com>
> Subject: Re: Major problem with PCMCIA/Yenta system

This is no regresssion[*], a fix is being evaluated.


Thanks,
	Dominik

[*] It may work on 2.4., though...
