Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261684AbTI3TGT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 15:06:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261687AbTI3TGT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 15:06:19 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:10459 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S261684AbTI3TGM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 15:06:12 -0400
To: Jens Axboe <axboe@suse.de>
Cc: "David S. Miller" <davem@redhat.com>, schilling@fokus.fraunhofer.de,
       linux-kernel@vger.kernel.org
Subject: Re: Kernel includefile bug not fixed after a year :-(
References: <200309301157.h8UBvOcd004345@burner.fokus.fraunhofer.de>
	<20030930120629.GM2908@suse.de>
	<20030930052817.0d0272df.davem@redhat.com>
	<20030930123804.GQ2908@suse.de>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 30 Sep 2003 16:41:32 +0200
In-Reply-To: <20030930123804.GQ2908@suse.de>
Message-ID: <m3ekxycp9f.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> writes:

> This discussion has spun off on a tangent. Joerg asked why that breakage
> has not been fixed, I point out why that is so. I usually make sure that
> whatever headers I mess with _do_ work from user space (cdrom.h is a
> long nasty example), however it's never been guarenteed that this would
> be the case for all kernel headers.

Then we should fix the broken headers so that it is guaranteed.
That's quite trivial, isn't it?

I don't really understand why it's that important to duplicate
definitions from kernel headers in libc ones.
IMHO glibc headers should include kernel headers instead of defining
things which are already defined by the kernel and used on kernel-user
interface.

Duplicate definitions should IMHO be removed from glibc headers.
-- 
Krzysztof Halasa, B*FH
