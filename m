Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751126AbWGKUWG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbWGKUWG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 16:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751137AbWGKUWF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 16:22:05 -0400
Received: from waha.wetafx.co.nz ([210.55.0.200]:4483 "EHLO waha.wetafx.co.nz")
	by vger.kernel.org with ESMTP id S1751126AbWGKUWE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 16:22:04 -0400
Message-ID: <44B40869.6030103@wetafx.co.nz>
Date: Wed, 12 Jul 2006 08:22:01 +1200
From: Bill Ryder <bryder@wetafx.co.nz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4) Gecko/20060516 Thunderbird/1.5.0.4 Mnenhy/0.7.4.0
MIME-Version: 1.0
To: ray-gmail@madrabbit.org
Cc: linux-kernel@vger.kernel.org, "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: [PATCH 2.6.18-rc1] Make group sorting optional in the 2.6.x kernels
References: <44B32888.6050406@wetafx.co.nz> <2c0942db0607111109n14353c50wdaf144214d572ffe@mail.gmail.com>
In-Reply-To: <2c0942db0607111109n14353c50wdaf144214d572ffe@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Ray Lee wrote:
> In addition to Randy's fine comments...
>
>
>
> It seems there's a third way to do this that would maintain
> setgroups(2) compatibility and speed when you have a lot of groups.
At least for NFS which is the problem here.
>
> Maintain the list of groups such that the first sixteen correspond to
> what setgroups(2) requested, and keep the rest sorted. A search for
> groups would then linearly check each of the first sixteen entries
> then, if there's more, binary search the remainder from 16 to
> group_info->ngroups.
That's a great idea.

I'll do that instead.

And next time I won't attach the patch :-)






