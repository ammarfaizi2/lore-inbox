Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751264AbWFSJR4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264AbWFSJR4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 05:17:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751265AbWFSJR4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 05:17:56 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:55200 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751264AbWFSJRz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 05:17:55 -0400
Subject: Re: UDF filesystem has some bugs on truncating
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: colin <colin@realtek.com.tw>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <045101c69108$4992a130$106215ac@realtek.com.tw>
References: <045101c69108$4992a130$106215ac@realtek.com.tw>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 19 Jun 2006 10:32:31 +0100
Message-Id: <1150709551.2503.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-06-16 am 13:47 +0800, ysgrifennodd colin:
> Hi all,
> I found that UDF has bugs on truncating.
> When you do this:
>     dd if=/dev/zero of=aaa bs=1024k count=2 seek=3000
> , Linux will hang and die.
> The platform is Linux 2.6.16 on MIPS malta board.

Ok I eventually sort of reproduced this on x86-64. It took a while
because in my environment I see a crash 2 or 3 hours after the test is
run, and that crash is on hardware that doesn't otherwise crash and
seems to be repeatable.

Alan

