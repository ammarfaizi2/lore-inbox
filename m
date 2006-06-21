Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751209AbWFUKjT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbWFUKjT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 06:39:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751237AbWFUKjT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 06:39:19 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:20452 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751209AbWFUKjT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 06:39:19 -0400
Subject: Re: [linux-usb-devel] USB/hal: USB open() broken? (USB CD burner
	underruns, USB HDD hard resets)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: 7eggert@gmx.de
Cc: andi@lisas.de, Andrew Morton <akpm@osdl.org>, gregkh@suse.de,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       hal@lists.freedesktop.org
In-Reply-To: <E1FsqGX-0001eu-AT@be1.lrz>
References: <6pnj7-32Q-7@gated-at.bofh.it> <6pJWg-34g-5@gated-at.bofh.it>
	 <6pKfL-3sx-29@gated-at.bofh.it> <6pKpl-3Sx-23@gated-at.bofh.it>
	 <6pLll-5iq-15@gated-at.bofh.it>  <E1FsqGX-0001eu-AT@be1.lrz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 21 Jun 2006 11:53:56 +0100
Message-Id: <1150887236.15275.37.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-06-21 am 02:07 +0200, ysgrifennodd Bodo Eggert:
> This does not work, since O_EXCL does not work:
> http://lkml.org/lkml/2006/2/5/137

It works fine. Its an advisory exclusive locking scheme which is
precisely what is needed and precisely how some vendors implement their
solution.

There are good reasons for not having absolute locks, one of which is
that you might want to force a reset or a hot unplug of an interface
knowing you'll lose the CD its burning (eg because your flight is about
to leave)

Alan

