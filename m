Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268127AbUIAVt6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268127AbUIAVt6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 17:49:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268117AbUIAVqY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 17:46:24 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:9016 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S268073AbUIAVoS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 17:44:18 -0400
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: f_ops flag to speed up compatible ioctls in linux kernel
X-Message-Flag: Warning: May contain useful information
References: <1094053222.431.7165.camel@cube>
	<20040901212314.GA26044@mellanox.co.il>
From: Roland Dreier <roland@topspin.com>
Date: Wed, 01 Sep 2004 14:44:01 -0700
In-Reply-To: <20040901212314.GA26044@mellanox.co.il> (Michael S. Tsirkin's
 message of "Thu, 2 Sep 2004 00:23:15 +0300")
Message-ID: <52656xzmu6.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 01 Sep 2004 21:44:02.0016 (UTC) FILETIME=[CB9D2E00:01C4906C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Michael> Now that I look at the ioctl.c code, I see a several
    Michael> get_user/put_user inside the ioctl which are thus done
    Michael> while BKL is held.  But I thought get_user can block?

    Michael> Why is this not a bug?

It's fine to sleep while holding the BKL (it will be dropped and then
reacquired when the process wakes up).

 - Roland

