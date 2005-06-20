Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261245AbVFTQhT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261245AbVFTQhT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 12:37:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261306AbVFTQhT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 12:37:19 -0400
Received: from mail.dvmed.net ([216.237.124.58]:52127 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261245AbVFTQhK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 12:37:10 -0400
Message-ID: <42B6F0AA.2060200@pobox.com>
Date: Mon, 20 Jun 2005 12:36:58 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "J.A. Magallon" <jamagallon@able.es>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-mm1
References: <1119267521l.17554l.1l@werewolf.able.es>
In-Reply-To: <1119267521l.17554l.1l@werewolf.able.es>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J.A. Magallon wrote:
> On 06.20, Andrew Morton wrote:
> 
>>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12/2.6.12-mm1/
>>
>>
>>- Someone broke /proc/device-tree on ppc64.  It's being looked into.
>>
>>- Nothing particularly special here - various fixes and updates.
>>
> 
> 
> I had this in my kernel, compiled from lkml ans supposed to fix some brakage
> realted to slab management in libata. Is still needed ?

It's a patch with bugs, that needs to be fixed.  You can't call 
scsi_eh_abort_cmds() without an abort handler, that won't accomplish too 
much.

	Jeff


