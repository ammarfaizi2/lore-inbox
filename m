Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422783AbWGJTH7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422783AbWGJTH7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 15:07:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422785AbWGJTH7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 15:07:59 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:57016 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S1422781AbWGJTH6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 15:07:58 -0400
Subject: Re: [2.6 patch] let BT_HIDP depend on INPUT
From: Marcel Holtmann <marcel@holtmann.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: maxk@qualcomm.com, bluez-devel@lists.sourceforge.net,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       linux390@de.ibm.com
In-Reply-To: <20060710183154.GD13938@stusta.de>
References: <20060710183154.GD13938@stusta.de>
Content-Type: text/plain
Date: Mon, 10 Jul 2006 21:07:20 +0200
Message-Id: <1152558440.32554.4.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

> This patch let's BT_HIDP depend on instead of select INPUT.
> 
> This fixes the following warning during an s390 build:
> 
> <--  snip  -->
> 
> ...
> net/bluetooth/hidp/Kconfig:4:warning: 'select' used by config symbol 'BT_HIDP' refer to undefined symbol 'INPUT'
> ...
> 
> <--  snip  -->
> 
> A dependency on INPUT also implies !S390 (and therefore makes the 
> explicit dependency obsolete) since INPUT is not available on s390.
> 
> The practical difference should be nearly zero, since INPUT is always 
> set to y unless EMBEDDED=y (or S390=y).

I actually have no idea why we ended up with using select, but depends
is also fine by me. Except I like to see it "BT && BT_L2CAP && INPUT" ;)

Regards

Marcel


