Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932071AbWIOPcj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbWIOPcj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 11:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932076AbWIOPcj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 11:32:39 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:53172 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932071AbWIOPcj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 11:32:39 -0400
Subject: Re: [-mm patch 2/3] AVR32 MTD: Unlock flash if necessary (try 2)
From: David Woodhouse <dwmw2@infradead.org>
To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-mtd@lists.infradead.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060915163711.10d19763@cad-250-152.norway.atmel.com>
References: <20060915163102.73bf171d@cad-250-152.norway.atmel.com>
	 <20060915163554.4f326bf6@cad-250-152.norway.atmel.com>
	 <20060915163711.10d19763@cad-250-152.norway.atmel.com>
Content-Type: text/plain
Date: Fri, 15 Sep 2006 16:32:26 +0100
Message-Id: <1158334346.24527.94.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-15 at 16:37 +0200, Haavard Skinnemoen wrote:
> If a cfi_cmdset_0002 fixup installs an unlock() operation, use it
> to unlock the whole flash after the erase regions have been set up.

There are cmdset_0001 chips which have this affliction too. I was
thinking of having a flag MTD_STUPID_LOCK which you set when you
determine that it's one of these chips, then add_mtd_device() can do the
unlocking... or add_mtd_partitions() can do it but _only_ for writable
partitions.

-- 
dwmw2

