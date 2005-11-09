Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965275AbVKIIF1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965275AbVKIIF1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 03:05:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965280AbVKIIF1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 03:05:27 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:21955
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S965275AbVKIIF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 03:05:27 -0500
Message-Id: <4371BC10.76F0.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Wed, 09 Nov 2005 09:06:24 +0100
From: "Jan Beulich" <JBeulich@novell.com>
To: "Andrew Morton" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i386: don't blindly enable interrupts in die()
References: <4370AE63.76F0.0078.0@novell.com> <20051108145721.2b98e6cf.akpm@osdl.org>
In-Reply-To: <20051108145721.2b98e6cf.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Andrew Morton <akpm@osdl.org> 08.11.05 23:57:21 >>>
>"Jan Beulich" <JBeulich@novell.com> wrote:
>>
>>  Rather than blindly re-enabling interrupts in die(), save their
state
>>  upon entry and then restore that state.
>
>What is the reason for this change?

If the kernel is in really bad condition and faults with interrupts
disabled, re-enabling them in die() may cause even more trouble,
implying more chances of data corruption.

