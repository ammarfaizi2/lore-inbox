Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265416AbTLHObC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 09:31:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265421AbTLHObC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 09:31:02 -0500
Received: from holomorphy.com ([199.26.172.102]:26331 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265416AbTLHObA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 09:31:00 -0500
Date: Mon, 8 Dec 2003 06:30:52 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: Chris Vine <chris@cvine.freeserve.co.uk>, Rik van Riel <riel@redhat.com>,
       linux-kernel@vger.kernel.org, "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: 2.6.0-test9 - poor swap performance on low end machines
Message-ID: <20031208143052.GI8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Con Kolivas <kernel@kolivas.org>,
	Chris Vine <chris@cvine.freeserve.co.uk>,
	Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org,
	"Martin J. Bligh" <mbligh@aracnet.com>
References: <Pine.LNX.4.44.0310302256110.22312-100000@chimarrao.boston.redhat.com> <200311041355.08731.kernel@kolivas.org> <20031208135225.GT19856@holomorphy.com> <200312090123.31895.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200312090123.31895.kernel@kolivas.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 09, 2003 at 01:23:31AM +1100, Con Kolivas wrote:
> [snip original discussion thrashing swap on 2.6test with 32mb ram]
> Chris
> By an unusual coincidence I was looking into the patches that were supposed to 
> speed up application startup and noticed this one was merged. A brief 
> discussion with wli suggests this could cause thrashing problems on low 
> memory boxes so can you try this patch? Applies to test11.

This is effectively only called when faulting on paged-out ptes whose
file offsets were disturbed by remap_file_pages() and when calling
remap_file_pages() itself.


-- wli
