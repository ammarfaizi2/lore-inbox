Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751393AbWAHNGs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393AbWAHNGs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 08:06:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752621AbWAHNGs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 08:06:48 -0500
Received: from canuck.infradead.org ([205.233.218.70]:11179 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S1751393AbWAHNGr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 08:06:47 -0500
Subject: Re: [2.6 patch] no longer mark MTD_OBSOLETE_CHIPS as BROKEN and
	remove broken MTD_OBSOLETE_CHIPS drivers
From: David Woodhouse <dwmw2@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mtd@lists.infradead.org
In-Reply-To: <20060108125700.GI3774@stusta.de>
References: <20060107220702.GZ3774@stusta.de>
	 <1136678409.30348.26.camel@pmac.infradead.org>
	 <20060108002457.GE3774@stusta.de>
	 <1136680734.30348.34.camel@pmac.infradead.org>
	 <20060107174523.460f1849.akpm@osdl.org>
	 <1136724072.30348.66.camel@pmac.infradead.org>
	 <20060108125700.GI3774@stusta.de>
Content-Type: text/plain
Date: Sun, 08 Jan 2006 13:06:20 +0000
Message-Id: <1136725580.30348.69.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-01-08 at 13:57 +0100, Adrian Bunk wrote:
> What I want for 2.6.16 is to remove the wrong dependency of MTD_SHARP on 
> BROKEN and the non-compiling drivers either still hidden under BROKEN or 
> removed.
> 
> If there is any way I can submit a patch achieving this that would be 
> acceptable for you simply tell how exactly you want this patch.

Remove the incorrect BROKEN dependency from MTD_OBSOLETE_CHIPS.

If you then want to add it again to any chip driver which really doesn't
compile, feel free. But leave the map drivers alone. Those can be
switched to use different chip back-ends. 

-- 
dwmw2

