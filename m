Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262744AbSI1GA6>; Sat, 28 Sep 2002 02:00:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262745AbSI1GA6>; Sat, 28 Sep 2002 02:00:58 -0400
Received: from holomorphy.com ([66.224.33.161]:6829 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S262744AbSI1GA5>;
	Sat, 28 Sep 2002 02:00:57 -0400
Date: Fri, 27 Sep 2002 23:04:50 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: mremap() pte allocation atomicity error
Message-ID: <20020928060450.GW3530@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
References: <20020928052813.GY22942@holomorphy.com> <3D95442E.C0959F4A@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D95442E.C0959F4A@digeo.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2002 at 10:54:54PM -0700, Andrew Morton wrote:
> A simple fix would be to drop the atomic kmap of the source pte
> and take it again after the alloc_one_pte_map() call.
> Can you think of a more efficient way?

Not one that isn't highly invasive, no. This is what I had in mind
for the easy fix.


Cheers,
Bill
