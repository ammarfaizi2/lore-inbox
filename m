Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161112AbWHDIm3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161112AbWHDIm3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 04:42:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161113AbWHDIm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 04:42:29 -0400
Received: from canuck.infradead.org ([205.233.218.70]:32384 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S1161112AbWHDIm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 04:42:28 -0400
Subject: Re: [PATCH] MTD: Add lock/unlock operations for Atmel AT49BV6416
From: David Woodhouse <dwmw2@infradead.org>
To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1154680114836-git-send-email-hskinnemoen@atmel.com>
References: <11546801142874-git-send-email-hskinnemoen@atmel.com>
	 <1154680114836-git-send-email-hskinnemoen@atmel.com>
Content-Type: text/plain
Date: Fri, 04 Aug 2006 16:41:12 +0800
Message-Id: <1154680873.31031.182.camel@shinybook.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.6.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-08-04 at 10:28 +0200, Haavard Skinnemoen wrote:
> What's the best way to do this? Unlock the flash in the board-specific
> mapping driver perhaps? 

That's what we used to do. If more people are emulating the Intel brain
damage and having chips which render the lock operation entirely
pointless by locking the chips at every power cycle, then I suppose we
ought to consider making auto-unlock a function of the chip type.

-- 
dwmw2

