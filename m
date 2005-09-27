Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965030AbVI0RsX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965030AbVI0RsX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 13:48:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965032AbVI0RsX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 13:48:23 -0400
Received: from quark.didntduck.org ([69.55.226.66]:63654 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S965030AbVI0RsW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 13:48:22 -0400
Message-ID: <4339863B.2080905@didntduck.org>
Date: Tue, 27 Sep 2005 13:49:47 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: mailarch@archivum.info
CC: linux-kernel@vger.kernel.org
Subject: Re: 128 kbytes allocation limit for kmalloc?
References: <20050927174032.GA26236@archivum.info>
In-Reply-To: <20050927174032.GA26236@archivum.info>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mailarch@archivum.info wrote:
> Hello,
> 
> is it possible to allocate more than 128 kbytes in a kernel lkm module?
> When I allocate more than 128 kbytes with the kmalloc call, kmalloc returns NULL.
> 

No.  Use vmalloc().  Keep in mind that kernel memory is a limited 
resource, so don't use more memory that you really have to.

--
				Brian Gerst
