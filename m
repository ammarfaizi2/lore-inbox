Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261620AbVBWW1U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261620AbVBWW1U (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 17:27:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261630AbVBWW0W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 17:26:22 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:62107 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S261646AbVBWWYG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 17:24:06 -0500
Date: Wed, 23 Feb 2005 23:22:49 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: 2.6.11-rc4-mm1
Message-ID: <20050223222249.GB30109@electric-eye.fr.zoreil.com>
References: <20050223014233.6710fd73.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050223014233.6710fd73.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> :
[...]
> - Last, final, ultimate call: if anyone has patches in here which are 2.6.11
>   material, please tell me.

Any chance to convince the alien who took control of Jeff's libata queue to
push:

r8169: synchronization and balancing when the device is closed

(1.1982.1.58 ?)

Test case on current 2.6.11-rc4:
- ifconfig ethX 10.0.0.1 up
- ifconfig ethX down
- ifconfig ethX 10.0.0.1 up
  -> Rx does not work any more
- ifconfig ethX down
  -> command hangs

--
Ueimor
