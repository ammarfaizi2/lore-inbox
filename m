Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964797AbWE3Wqx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964797AbWE3Wqx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 18:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964798AbWE3Wqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 18:46:52 -0400
Received: from hera.kernel.org ([140.211.167.34]:34198 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S964797AbWE3Wqw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 18:46:52 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Sharing memory between kernel and user space
Date: Tue, 30 May 2006 15:46:17 -0700 (PDT)
Organization: Mostly alphabetical, except Q, with we do not fancy
Message-ID: <e5ihvp$qd1$1@terminus.zytor.com>
References: <14CFC56C96D8554AA0B8969DB825FEA0012B331A@chicken.machinevisionproducts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1149029177 27042 127.0.0.1 (30 May 2006 22:46:17 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Tue, 30 May 2006 22:46:17 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <14CFC56C96D8554AA0B8969DB825FEA0012B331A@chicken.machinevisionproducts.com>
By author:    "Brian D. McGrew" <brian@visionpro.com>
In newsgroup: linux.dev.kernel
>
> I have a question about the best way to share memory between user and
> kernel space.
> 

In general, allocate the memory in kernel space (via get_free_page et
al), and make accessible to userspace via mmap on a device node.

	-hpa
