Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261678AbULBQpZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261678AbULBQpZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 11:45:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261255AbULBQpZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 11:45:25 -0500
Received: from cantor.suse.de ([195.135.220.2]:16817 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261678AbULBQpT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 11:45:19 -0500
To: Jan Kasprzak <kas@fi.muni.cz>
Cc: Arnd Bergmann <arnd@arndb.de>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cosa.h ioctl numbers
References: <20041202124456.GF11992@fi.muni.cz>
	<200412021358.00844.arnd@arndb.de> <20041202131224.GI11992@fi.muni.cz>
	<jeu0r4ajl4.fsf@sykes.suse.de> <20041202141132.GO11992@fi.muni.cz>
	<jellcgag2v.fsf@sykes.suse.de> <20041202155559.GR11992@fi.muni.cz>
From: Andreas Schwab <schwab@suse.de>
X-Yow: ..  Once upon a time, four AMPHIBIOUS HOG CALLERS attacked a family
 of DEFENSELESS, SENSITIVE COIN COLLECTORS and brought DOWN their
 PROPERTY VALUES!!
Date: Thu, 02 Dec 2004 17:45:18 +0100
In-Reply-To: <20041202155559.GR11992@fi.muni.cz> (Jan Kasprzak's message of
 "Thu, 2 Dec 2004 16:56:00 +0100")
Message-ID: <jevfbkabtt.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Kasprzak <kas@fi.muni.cz> writes:

> 	I do not understand. The _IOW() macro just uses sizeof(_third_argument)
> both on 2.4 and 2.6.

Yes, and 2.4 uses sizeof in the third argument, thus size_t is the most
natural replacement.

> I would rather have the 2.6 ioctl numbers the same as in 2.1-2.4.

You get that when you use size_t for the type, which also gives some hint
that the old definition was an unfortunate mistake and might prevent other
people from "fixing" it again.  Putting a pointer here just adds to the
confusion and should be avoided, IMHO.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
