Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261576AbUJaLf7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261576AbUJaLf7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 06:35:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261580AbUJaLfV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 06:35:21 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:6632 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261568AbUJaKmD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 05:42:03 -0500
Message-ID: <4184C16E.80705@pobox.com>
Date: Sun, 31 Oct 2004 05:41:50 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: geert@linux-m68k.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org
Subject: Re: [PATCH 475] HP300 LANCE
References: <200410311003.i9VA3UMN009557@anakin.of.borg>	<4184BB09.8000107@pobox.com> <20041031021933.1eba86a6.akpm@osdl.org>
In-Reply-To: <20041031021933.1eba86a6.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Jeff Garzik <jgarzik@pobox.com> wrote:
> 
>>content looks OK, but patch appears to be whitespace-challenged...
>>
> 
> 
> It applies successfully.

I'm talking about the _other_ type of "whitespace challenged", such as,

-        volatile struct lance_regs *ll;
+	unsigned long base;

	and

-        void *va = dio_scodetoviraddr(scode);
+	unsigned long pa = dio_scodetophysaddr(scode);
+        unsigned long va = (pa + DIO_VIRADDRBASE);

Reading through the patch you can see other one-space-off spots.

	Jeff


