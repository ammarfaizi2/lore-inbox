Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262776AbSJWC5u>; Tue, 22 Oct 2002 22:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262789AbSJWC5t>; Tue, 22 Oct 2002 22:57:49 -0400
Received: from zero.aec.at ([193.170.194.10]:20236 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id <S262776AbSJWC5t>;
	Tue, 22 Oct 2002 22:57:49 -0400
To: Gerrit Huizenga <gh@us.ibm.com>
Cc: akpm@digeo.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5.43-mm2] New shared page table patch
References: <3DB59DA7.453F89E2@digeo.com> <E1844MH-00027H-00@w-gerrit2>
From: Andi Kleen <ak@muc.de>
Date: 23 Oct 2002 05:03:38 +0200
In-Reply-To: <E1844MH-00027H-00@w-gerrit2>
Message-ID: <m3fzuxq2k5.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gerrit Huizenga <gh@us.ibm.com> writes:

> If the shared pte patch had mmap support, then all shared libraries
> would benefit.  Might need to align them to 4 MB boundaries for best
> results, which would also be easy for libraries with unspecified
> attach addresses (e.g. most shared libraries).

But only if the shared libraries are a multiple of 2/4MB, otherwise you'll
waste memory. Or do you propose to link multiple mmap'ed libraries together
into the same page ? 

But I agree it would be nice to have a chattr for files that tells
mmap() to use large pages for them.

-Andi
