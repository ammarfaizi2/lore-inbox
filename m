Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932286AbWF0OBq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932286AbWF0OBq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 10:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932316AbWF0OBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 10:01:46 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:20355 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932286AbWF0OBp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 10:01:45 -0400
Date: Tue, 27 Jun 2006 15:59:04 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Nigel Cunningham <nigel@suspend2.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Suspend2][ 00/13] Compression support.
Message-ID: <20060627135904.GD3019@elf.ucw.cz>
References: <20060627043716.14320.30977.stgit@nigel.suspend2.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060627043716.14320.30977.stgit@nigel.suspend2.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Patches which implement support for compressing the image. We use
> cryptoapi. A separate patch adds an LZF compression module, which
> is much faster than gzip.

This is diffstat of compression/encryption patches:

 b/kernel/power/compression.c |   43 +++
 b/kernel/power/encryption.c  |   49 +++
 kernel/power/compression.c   |  559 +++++++++++++++++++++++++++++++++++++++++--
 kernel/power/encryption.c    |  517 +++++++++++++++++++++++++++++++++++++--
 4 files changed, 1115 insertions(+), 53 deletions(-)

..so we add 1000 lines of code for feature that can very well live in
userspace. All the filewriters/etc can live in userspace, too.

Could we improve suspend.sf.net code instead of trying to merge awful
lot of code that does not really belong into kernel?

I counted over 300 patches in this series....
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
