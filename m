Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932164AbWGGOhw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbWGGOhw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 10:37:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932172AbWGGOhw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 10:37:52 -0400
Received: from pat.uio.no ([129.240.10.4]:59043 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932164AbWGGOhu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 10:37:50 -0400
Subject: Re: ext4 features
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: 7eggert@gmx.de
Cc: Bill Davidsen <davidsen@tmr.com>, "J. Bruce Fields" <bfields@fieldses.org>,
       Theodore Tso <tytso@mit.edu>,
       Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <E1Fymn1-0000g6-7s@be1.lrz>
References: <6tVcC-1e1-79@gated-at.bofh.it> <6uXYv-3RG-1@gated-at.bofh.it>
	 <6veG8-350-7@gated-at.bofh.it> <6vfiU-465-13@gated-at.bofh.it>
	 <6vmNk-77r-23@gated-at.bofh.it> <6vnq7-7Tw-55@gated-at.bofh.it>
	 <6vrN0-5Se-9@gated-at.bofh.it> <6vBsY-38p-9@gated-at.bofh.it>
	 <E1Fymn1-0000g6-7s@be1.lrz>
Content-Type: text/plain
Date: Fri, 07 Jul 2006 10:37:28 -0400
Message-Id: <1152283049.5726.26.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.257, required 12,
	autolearn=disabled, AWL 1.56, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-07 at 11:38 +0200, Bodo Eggert wrote:

> If the changes to these files are very infrequent compared to nanoseconds,
> you'll only need the version during some nanoseconds, and only during
> runtime. Having a second-change-within-one-timeframe-flag(*) instead of
> versions will be enough to make NFS mostly happy and only penalize your
> users for one nanosecond, and it won't force version-keeping into the
> filesystem. And besides that, all other filesystems will profit even
> without having nanosecond resolution nor versioning (but they'll suffer
> for up to a whole second).

NFS never required file versioning. You're talking to the wrong person.
It does, however, need a change attribute that logs all changes to the
file. The above flag does not suffice to provide that.

Trond

