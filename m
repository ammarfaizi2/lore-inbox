Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261245AbTENTTj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 15:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261279AbTENTTj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 15:19:39 -0400
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:7309 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S261245AbTENTTh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 15:19:37 -0400
Date: Wed, 14 May 2003 15:32:19 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Martin Hicks <mort@wildopensource.com>
cc: linux-kernel@vger.kernel.org, <wildos@sgi.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH] Don't add empty PTE's to mmu_gathers
In-Reply-To: <20030512171722.GT11947@bork.org>
Message-ID: <Pine.LNX.4.44.0305141530570.10617-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 May 2003, Martin Hicks wrote:

> Here's a patch to make it so empty PTEs are not added to mmu_gathers.
> This is useful on machines with sparse memory.  This has been tested on
> ia64 and x86.  Patch is against 2.4.21-bk.

The patch looks good.  We will still flush everything in the
TLB that we used to flush before, but by not using struct
page in the buffer for non-existant and reserved pages we can
flush the TLB in much larger intervals.

Marcelo, could you please apply this patch for 2.4.22-pre ?

(I'll keep a copy here and will resend it to you if needed)

