Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267359AbUBSWB5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 17:01:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267386AbUBSWB5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 17:01:57 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:20150 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S267359AbUBSWBo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 17:01:44 -0500
Subject: Re: 2.6.3-mm1
From: Christophe Saout <christophe@saout.de>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <403531A3.4000503@tmr.com>
References: <1qujU-5xX-31@gated-at.bofh.it> <1qCUf-4vn-41@gated-at.bofh.it>
	 <1qGuR-bb-25@gated-at.bofh.it> <1qGO2-uG-13@gated-at.bofh.it>
	 <1qGO5-uG-21@gated-at.bofh.it> <1qGY1-RT-29@gated-at.bofh.it>
	 <1qGY1-RT-27@gated-at.bofh.it> <1qIn3-5yq-23@gated-at.bofh.it>
	 <403531A3.4000503@tmr.com>
Content-Type: text/plain
Message-Id: <1077228093.17599.4.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Thu, 19 Feb 2004 23:01:33 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Do, den 19.02.2004 schrieb Bill Davidsen um 22:58:

> Could you give an example of the one line I put in /etc/fstab to replace 
> the one now which includes "noauto,user" so users can mount when they 
> need the secure data?
>
> You *can* do that so you don't need to train users, give them special 
> permissions, or use privileged scripts or programs, right?

That's not possible at the moment. What you want to do relies on the
feature that the mount command itself does the required setup. The would
require to have some dedicated C code fot the device setup and make
mount use that (through a patch). mount currently only knows about the
loop device. And BTW the key management sucks if you use an unpatched
mount because it uses the unhashed passphrase unhashed key.


