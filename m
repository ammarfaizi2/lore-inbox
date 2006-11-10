Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946295AbWKJKV2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946295AbWKJKV2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 05:21:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946306AbWKJKV2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 05:21:28 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:44712 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1946295AbWKJKV1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 05:21:27 -0500
Subject: Re: [PATCH 2.6.19 5/5] fs: freeze_bdev with semaphore not mutex
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Alasdair G Kergon <agk@redhat.com>,
       Eric Sandeen <sandeen@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, dm-devel@redhat.com,
       Srinivasa DS <srinivasa@in.ibm.com>,
       Nigel Cunningham <nigel@suspend2.net>, David Chinner <dgc@sgi.com>
In-Reply-To: <20061109211722.GA2616@elf.ucw.cz>
References: <20061107183459.GG6993@agk.surrey.redhat.com>
	 <200611091652.34649.rjw@sisk.pl> <20061109160003.GA24156@elf.ucw.cz>
	 <200611092059.48722.rjw@sisk.pl>  <20061109211722.GA2616@elf.ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 10 Nov 2006 10:24:09 +0000
Message-Id: <1163154249.7900.19.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-11-09 am 22:17 +0100, ysgrifennodd Pavel Machek:
> Why not simply &~ PF_NOFREEZE on that particular process? Filesystems
> are free to use threads/work queues/whatever, but refrigerator should
> mean "no writes to filesystem" for them...

You can't go around altering the flags of another process - what locking
are you relying upon for this ?


