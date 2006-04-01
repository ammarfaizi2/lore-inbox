Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751042AbWDAPEz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751042AbWDAPEz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Apr 2006 10:04:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751514AbWDAPEz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Apr 2006 10:04:55 -0500
Received: from ns2.suse.de ([195.135.220.15]:22714 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751052AbWDAPEy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Apr 2006 10:04:54 -0500
From: Andreas Schwab <schwab@suse.de>
To: Wu Fengguang <wfg@mail.ustc.edu.cn>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386 zone_sizes_init() fix
References: <20060401131011.GA10804@mail.ustc.edu.cn>
X-Yow: Not enough people play SKEE-BALL..  They're always thinking about
 COCAINE or and ALIEN BEINGS!!
Date: Sat, 01 Apr 2006 17:04:47 +0200
In-Reply-To: <20060401131011.GA10804@mail.ustc.edu.cn> (Wu Fengguang's message
	of "Sat, 1 Apr 2006 21:10:11 +0800")
Message-ID: <jeacb5pca8.fsf@sykes.suse.de>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wu Fengguang <wfg@mail.ustc.edu.cn> writes:

> Now that with MAX_NR_ZONES=4, the last element of zones_size[] is
> left uninitialized in zone_sizes_init() on i386.

No, it isn't.  In the presence of an initializer any element not
explicitly initialized will be set to 0 of the appropriate type.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
