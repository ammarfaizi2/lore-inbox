Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751138AbWDJNq4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751138AbWDJNq4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 09:46:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751157AbWDJNqz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 09:46:55 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:56584 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1751138AbWDJNqy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 09:46:54 -0400
Date: Mon, 10 Apr 2006 09:46:30 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: Michael Buesch <mb@bu3sch.de>
Cc: Benoit Boissinot <benoit.boissinot@ens-lyon.org>, netdev@vger.kernel.org,
       bcm43xx-dev@lists.berlios.de, linux-kernel@vger.kernel.org,
       benh@kernel.crashing.org
Subject: Re: [RFC/PATCH] remove unneeded check in bcm43xx
Message-ID: <20060410134625.GA25360@tuxdriver.com>
Mail-Followup-To: Michael Buesch <mb@bu3sch.de>,
	Benoit Boissinot <benoit.boissinot@ens-lyon.org>,
	netdev@vger.kernel.org, bcm43xx-dev@lists.berlios.de,
	linux-kernel@vger.kernel.org, benh@kernel.crashing.org
References: <20060410040120.GA4860@ens-lyon.fr> <200604100607.33362.mb@bu3sch.de> <20060410042228.GN27596@ens-lyon.fr> <200604100628.01483.mb@bu3sch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604100628.01483.mb@bu3sch.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10, 2006 at 06:28:00AM +0200, Michael Buesch wrote:

> To summerize: I actually added these messages, because people were
> hitting "this does not work with >1G" issues and did not get an error message.
> So I decided to insert warnings until the issue is fixed inside the arch code.
> I will remove them once the issue is fixed.

This sounds like the same sort of problems w/ the b44 driver.
I surmise that both use the same (broken) DMA engine from Broadcom.

Unfortunately, I don't know of any good solution to this.  There are
a few hacks in b44 that deal with the issue.  I don't like them,
although I am the perpetrator of at least one of them.  It might be
worth looking at what was done there?

YMMV...

John
-- 
John W. Linville
linville@tuxdriver.com
