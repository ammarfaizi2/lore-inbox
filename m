Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262812AbTBXXgZ>; Mon, 24 Feb 2003 18:36:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262821AbTBXXgZ>; Mon, 24 Feb 2003 18:36:25 -0500
Received: from holomorphy.com ([66.224.33.161]:28339 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S262812AbTBXXgY>;
	Mon, 24 Feb 2003 18:36:24 -0500
Date: Mon, 24 Feb 2003 15:45:36 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Paul Larson <plars@linuxtestproject.org>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pte_alloc_kernel needs additional check
Message-ID: <20030224234536.GT10411@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>,
	Paul Larson <plars@linuxtestproject.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
References: <1046123680.13919.67.camel@plars> <20030224143341.0b3e1faa.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030224143341.0b3e1faa.akpm@digeo.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Larson <plars@linuxtestproject.org> wrote:
-	return pte_offset_kernel(pmd, address);
+	if (pmd_present(*pmd))
+		return pte_offset_kernel(pmd, address);
+	return NULL;

On Mon, Feb 24, 2003 at 02:33:41PM -0800, Andrew Morton wrote:
> Confused.  I cannot see a codepath which makes this test necessary?

Looks like it's OOM handling by analogy with pte_alloc_map().

-- wli
