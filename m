Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262876AbUKTNDa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262876AbUKTNDa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 08:03:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262898AbUKTNDa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 08:03:30 -0500
Received: from canuck.infradead.org ([205.233.218.70]:45577 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S262876AbUKTND2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 08:03:28 -0500
Subject: Re: [patch 07/10]  mtd/amd_flash: replace 	schedule_timeout() with
	msleep()
From: David Woodhouse <dwmw2@infradead.org>
To: janitor@sternwelten.at
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, nacc@us.ibm.com
In-Reply-To: <E1CVL5L-0001V3-BQ@sputnik>
References: <E1CVL5L-0001V3-BQ@sputnik>
Content-Type: text/plain
Date: Sat, 20 Nov 2004 12:59:35 +0000
Message-Id: <1100955575.8600.29.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 1.0 (+)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (1.0 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.0 SUBJ_HAS_SPACES        Subject contains lots of white space
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-11-20 at 03:34 +0100, janitor@sternwelten.at wrote:
> 
> 
> Any comments would be appreciated.
> 
> Description: Use msleep() instead of schedule_timeout()
> to guarantee the task delays as expected.

Applied; thanks. Likewise the ones for cfi_cmdset_0002.c and
cfi_cmdset_0020.c. The one for cfi_cmdset_0001.c doesn't apply any more
-- that just uses the cfi_udelay() helper function. So I fixed that too.
All in bk://linux-mtd.bkbits.net/mtd-2.6 and hence should be -mm$NEXT.

-- 
dwmw2

