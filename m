Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268157AbUIAWB5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268157AbUIAWB5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 18:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268216AbUIAVzk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 17:55:40 -0400
Received: from fw.osdl.org ([65.172.181.6]:16275 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267968AbUIAVn6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 17:43:58 -0400
Date: Wed, 1 Sep 2004 14:43:57 -0700
From: Chris Wright <chrisw@osdl.org>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: f_ops flag to speed up compatible ioctls in linux kernel
Message-ID: <20040901144357.F1973@build.pdx.osdl.net>
References: <1094053222.431.7165.camel@cube> <20040901212314.GA26044@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20040901212314.GA26044@mellanox.co.il>; from mst@mellanox.co.il on Thu, Sep 02, 2004 at 12:23:15AM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Michael S. Tsirkin (mst@mellanox.co.il) wrote:
> Now that I look at the ioctl.c code, I see a several get_user/put_user
> inside the ioctl which are thus done while BKL is held.
> But I thought get_user can block?
> 
> Why is this not a bug?

Look at release_kernel_lock, esp. in kernel/sched.c.
-chris
