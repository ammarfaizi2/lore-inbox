Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261640AbULBPNc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261640AbULBPNc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 10:13:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261642AbULBPNb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 10:13:31 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:20140 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261640AbULBPNa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 10:13:30 -0500
To: Jan Kasprzak <kas@fi.muni.cz>
Cc: Arnd Bergmann <arnd@arndb.de>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cosa.h ioctl numbers
References: <20041202124456.GF11992@fi.muni.cz>
	<200412021358.00844.arnd@arndb.de> <20041202131224.GI11992@fi.muni.cz>
	<jeu0r4ajl4.fsf@sykes.suse.de> <20041202141132.GO11992@fi.muni.cz>
From: Andreas Schwab <schwab@suse.de>
X-Yow: I decided to be JOHN TRAVOLTA instead!!
Date: Thu, 02 Dec 2004 16:13:28 +0100
In-Reply-To: <20041202141132.GO11992@fi.muni.cz> (Jan Kasprzak's message of
 "Thu, 2 Dec 2004 15:11:32 +0100")
Message-ID: <jellcgag2v.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Kasprzak <kas@fi.muni.cz> writes:

> Andreas Schwab wrote:
> : If you want real compatibility you should use size_t, which is what 2.4 is
> : effectively using.
> : 
> 	I assume that sizeof(struct .. *) == sizeof(size_t) on i386.

This has nothing to do with this, but everything to do with
sizeof(sizeof(foo)) == sizeof(size_t).  And COSAIODOWNLD does not expect a
pointer to a pointer but a pointer to struct cosa_download, which means
that _IOW('C',0xf2,struct cosa_download *) would be completely wrong
anyway.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
