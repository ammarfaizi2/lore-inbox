Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261161AbVAMFlz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261161AbVAMFlz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 00:41:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261160AbVAMFlz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 00:41:55 -0500
Received: from adsl-298.mirage.euroweb.hu ([193.226.239.42]:6278 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261158AbVAMFlw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 00:41:52 -0500
To: akpm@osdl.org
CC: torvalds@osdl.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-reply-to: <20050112144402.38a8a337.akpm@osdl.org> (message from Andrew
	Morton on Wed, 12 Jan 2005 14:44:02 -0800)
Subject: Re: [PATCH 3/11] FUSE - device functions
References: <E1CoOq3-0003Jq-00@dorka.pomaz.szeredi.hu> <20050112144402.38a8a337.akpm@osdl.org>
Message-Id: <E1Coxjk-0002WI-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 13 Jan 2005 06:41:36 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Does all this userspace communication code work OK if it is talking with a
> 32-bit application from a 64-bit kernel?

Yes, all the structure members have explicit size (u32 or u64).

> Standard question: was netlink considered?

Yes, but it does not give me enough control over the communication.

For example the READ operation currently passes the page(s) to be
filled to the FUSE device handler, and when the READ reply is sent by
userspace, data is copied directly to those pages.  With a socket
based solution immediate buffers would be needed.

Thanks,
Miklos
