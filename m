Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751125AbWH3QaE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbWH3QaE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 12:30:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750962AbWH3QaE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 12:30:04 -0400
Received: from tetsuo.zabbo.net ([207.173.201.20]:62950 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S1751125AbWH3QaB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 12:30:01 -0400
Message-ID: <44F5BD08.1020700@zabbo.net>
Date: Wed, 30 Aug 2006 09:30:00 -0700
From: Zach Brown <zab@zabbo.net>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Yi Yang <yang.y.yi@gmail.com>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       linux-aio <linux-aio@kvack.org>, torvalds@osdl.org
Subject: Re: [2.6.18-rc5 PATCH]: aio cleanup
References: <44F43F46.1070702@gmail.com> <44F48825.4050408@zabbo.net> <44F59E79.2080402@gmail.com>
In-Reply-To: <44F59E79.2080402@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yi Yang wrote:
> As Zach Brown said, a cleanup patch is reasonable. Here it is.

I said a cleanup patch could be reasonable :)

> This patch extracts the common part from aio_fsync and aio_fdsync
> and define a new inlined function aio_xsync, then aio_fsync and
> aio_fdsync just call aio_xsunc in the almost same way except second
> argument is different, one is 1 and another 0.

I don't think we need to change this, to be honest.  They're tiny
functions without users.  It doesn't seem worth the trouble, minimal
though it is.

Maybe if we had ->aio_fsync() users it would be more clear if there was
an opportunity to really clarify the interface.

- z
