Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261785AbTEVLvt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 07:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261788AbTEVLvt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 07:51:49 -0400
Received: from holomorphy.com ([66.224.33.161]:25739 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261785AbTEVLvs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 07:51:48 -0400
Date: Thu, 22 May 2003 05:04:24 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Martin Wirth <martin.wirth@dlr.de>, linux-kernel@vger.kernel.org,
       rusty@rustcorp.com.au
Subject: Re: [patch] futex requeueing feature, futex-requeue-2.5.69-D3
Message-ID: <20030522120424.GP8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ingo Molnar <mingo@elte.hu>, Martin Wirth <martin.wirth@dlr.de>,
	linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
References: <3ECCB319.4060706@dlr.de> <Pine.LNX.4.44.0305221328130.6965-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0305221328130.6965-100000@localhost.localdomain>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 22, 2003 at 01:34:42PM +0200, Ingo Molnar wrote:
> there's a patch in the works to change futex hashing to not require page
> pinning, without making futexes process-local. This should also fix the
> FUTEX_FD problems.
> basically the idea is that struct page remains to be a good hash whenever
> the page is present, and the swapout pte value is a good hash key when the
> page is swapped out. So we basically can make futexes swappable.
> this gets rid of pinned pages and pagetable locking, without the need for
> API-level changes.

Someone's already doing it? I'll back off if so.


-- wli
