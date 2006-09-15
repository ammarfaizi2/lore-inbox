Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751565AbWIOEdu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751565AbWIOEdu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 00:33:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751566AbWIOEdu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 00:33:50 -0400
Received: from extu-mxob-1.symantec.com ([216.10.194.28]:6575 "EHLO
	extu-mxob-1.symantec.com") by vger.kernel.org with ESMTP
	id S1750996AbWIOEdt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 00:33:49 -0400
X-AuditID: 7f000001-a5fcabb0000063f4-62-450a2c6abee7 
Date: Fri, 15 Sep 2006 05:30:18 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Yingchao Zhou <yc_zhou@ncic.ac.cn>
cc: linux-kernel <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>,
       alan <alan@redhat.com>, zxc <zxc@ncic.ac.cn>
Subject: Re: Re: Re: [RFC] PAGE_RW Should be added to PAGE_COPY ?
In-Reply-To: <20060915033842.C205FFB045@ncic.ac.cn>
Message-ID: <Pine.LNX.4.64.0609150514190.7397@blonde.wat.veritas.com>
References: <20060915033842.C205FFB045@ncic.ac.cn>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 15 Sep 2006 04:30:13.0394 (UTC) FILETIME=[A3029720:01C6D87F]
X-Brightmail-Tracker: AAAAAA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Sep 2006, Yingchao Zhou wrote:
> >On Fri, 15 Sep 2006, Yingchao Zhou wrote:
> >> It's ok to mmap MAP_SHARED. But is it not a normal way to malloc() a space and
> >> then registered to NIC ?
> >
> >Not that I know of.  How would one register malloc()ed space to a NIC?
> >Sorry, I may well be misunderstanding you.
> The user-level NIC does this, eg. Myrinet...

Okay, thanks, I know nothing of that, and must defer to those who do.

But it sounds broken to me, in the way that you have described.

And the fix would not be to change the kernel's semantics for private
mappings, but for the app to use a shared mapping instead of a private.

Which would indeed be more work for the app than just using malloc,
since it needs some memory object (e.g. tmpfs file?) to map shared.

Hugh
