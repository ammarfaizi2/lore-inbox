Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263752AbUGMDlW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263752AbUGMDlW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 23:41:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263815AbUGMDlW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 23:41:22 -0400
Received: from mail4.speakeasy.net ([216.254.0.204]:23003 "EHLO
	mail4.speakeasy.net") by vger.kernel.org with ESMTP id S263752AbUGMDlU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 23:41:20 -0400
Subject: Re: [2.6 patch] eth1394: remove an inline
From: Steve Kinneberg <kberg@pobox.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Ben Collins <bcollins@debian.org>, linux1394-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040713002720.GD4701@fs.tum.de>
References: <20040713002720.GD4701@fs.tum.de>
Content-Type: text/plain
Message-Id: <1089690079.2725.40.camel@dell>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 12 Jul 2004 20:41:19 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-07-12 at 17:27, Adrian Bunk wrote:
> Trying to compile drivers/ieee1394/eth1394.c with gcc 3.4 and
>   # define inline         __inline__ __attribute__((always_inline))
> results in the following compile error:
> 
> <--  snip  -->
> 
> ...
>   CC      drivers/ieee1394/eth1394.o
> drivers/ieee1394/eth1394.c: In function `eth1394_remove':
> drivers/ieee1394/eth1394.c:189: sorry, unimplemented: inlining failed in 
> call to 'purge_partial_datagram': function body not available
> drivers/ieee1394/eth1394.c:403: sorry, unimplemented: called from here
> make[2]: *** [drivers/ieee1394/eth1394.o] Error 1
> 
> <--  snip  -->

Thanks.  Patch committed.
-- 
Steve Kinneberg

