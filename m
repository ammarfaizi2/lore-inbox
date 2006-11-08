Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753788AbWKHAmN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753788AbWKHAmN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 19:42:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753791AbWKHAmN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 19:42:13 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:30936 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1753788AbWKHAmM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 19:42:12 -0500
Message-ID: <455127E3.1050301@vmware.com>
Date: Tue, 07 Nov 2006 16:42:11 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060909)
MIME-Version: 1.0
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andrew Morton <akpm@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix kunmap_atomic's use of kpte_clear_flush()
References: <4551232A.4020203@goop.org>
In-Reply-To: <4551232A.4020203@goop.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Fitzhardinge wrote:
> kunmap_atomic() will call kpte_clear_flush with vaddr/ptep arguments
> which don't correspond if the vaddr is just a normal lowmem address
> (ie, not in the KMAP area).  This patch makes sure that the pte is
> only cleared if kmap area was actually used for the mapping.
>
> Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
> Cc: Zachary Amsden <zach@vmware.com>

Ack.
