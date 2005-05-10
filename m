Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261507AbVEJBpe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261507AbVEJBpe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 21:45:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261518AbVEJBpe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 21:45:34 -0400
Received: from mail.dvmed.net ([216.237.124.58]:62621 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261507AbVEJBpa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 21:45:30 -0400
Message-ID: <42801232.8000009@pobox.com>
Date: Mon, 09 May 2005 21:45:22 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Yoav Zach <yoav_zach@yahoo.com>
CC: torvalds@osdl.org, lkml <linux-kernel@vger.kernel.org>,
       Yoav Zach <yoav.zach@intel.com>
Subject: Re: [PATCH]: Don't force O_LARGEFILE for 32 bit processes on ia64
 - 2.6.12-rc3
References: <20050509214710.419.qmail@web50610.mail.yahoo.com>
In-Reply-To: <20050509214710.419.qmail@web50610.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yoav Zach wrote:
> In ia64 kernel, the O_LARGEFILE flag is forced when
> opening a file. This is problematic for execution of
> 32 bit processes, which are not largefile aware, either
> by SW emulation or by HW execution.
> For such processes, the problem is two-fold:
> 1) When trying to open a file that is larger than 4G
>    the operation should fail, but it's not
> 2) Writing to offset larger than 4G should fail, but
>    it's not

O_LARGEFILE works great on my 32-bit platform.

Is this an ABI bug?  O_LARGEFILE should be OK for 32-bit processes.

	Jeff



