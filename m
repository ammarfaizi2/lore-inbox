Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261373AbSJ1Q7f>; Mon, 28 Oct 2002 11:59:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261376AbSJ1Q7f>; Mon, 28 Oct 2002 11:59:35 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:27120 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261373AbSJ1Q7d>;
	Mon, 28 Oct 2002 11:59:33 -0500
Date: Mon, 28 Oct 2002 09:00:14 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@digeo.com>
cc: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm show_free_areas layout
Message-ID: <526010000.1035824414@flay>
In-Reply-To: <Pine.LNX.4.44.0210281628550.10378-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0210281628550.10378-100000@localhost.localdomain>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Could we rearrange it? with the hot and cold taps and batchwater
> levels first: those who are interested can swim back to them?
> Omit the word "Zone " (I'd love non-NUMAs to omit "Node 0 " but
> didn't find the right #define).  

#ifdef CONFIG_NUMA, or for less ugly code, you should just be able
to do "if (numnodes > 1)", which will optimise away by the compiler
on non-NUMA.

M.

