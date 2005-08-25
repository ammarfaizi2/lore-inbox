Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932521AbVHYUCh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932521AbVHYUCh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 16:02:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932522AbVHYUCg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 16:02:36 -0400
Received: from mx1.redhat.com ([66.187.233.31]:10144 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932521AbVHYUCg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 16:02:36 -0400
Date: Thu, 25 Aug 2005 13:31:39 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@cuia.boston.redhat.com
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Ray Fucillo <fucillo@intersystems.com>, linux-kernel@vger.kernel.org
Subject: Re: process creation time increases linearly with shmem
In-Reply-To: <430D0D6B.100@yahoo.com.au>
Message-ID: <Pine.LNX.4.63.0508251331040.25774@cuia.boston.redhat.com>
References: <430CBFD1.7020101@intersystems.com> <430D0D6B.100@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Aug 2005, Nick Piggin wrote:

> fork() can be changed so as not to set up page tables for
> MAP_SHARED mappings. I think that has other tradeoffs like
> initially causing several unavoidable faults reading
> libraries and program text.

Actually, libraries and program text are usually mapped
MAP_PRIVATE, so those would still be copied.

Skipping MAP_SHARED in fork() sounds like a good idea to me...

-- 
All Rights Reversed
