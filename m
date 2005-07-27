Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262182AbVG0Brv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262182AbVG0Brv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 21:47:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262346AbVG0Brv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 21:47:51 -0400
Received: from dvhart.com ([64.146.134.43]:38329 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S262182AbVG0Bru (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 21:47:50 -0400
Date: Tue, 26 Jul 2005 18:47:46 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Andrew Morton <akpm@osdl.org>
Cc: pbadari@us.ibm.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: Memory pressure handling with iSCSI
Message-ID: <200250000.1122428866@flay>
In-Reply-To: <20050726182631.668e2da2.akpm@osdl.org>
References: <1122399331.6433.29.camel@dyn9047017102.beaverton.ibm.com><20050726111110.6b9db241.akpm@osdl.org><1122403152.6433.39.camel@dyn9047017102.beaverton.ibm.com><20050726114824.136d3dad.akpm@osdl.org><20050726121250.0ba7d744.akpm@osdl.org><1122412301.6433.54.camel@dyn9047017102.beaverton.ibm.com><20050726142410.4ff2e56a.akpm@osdl.org><1122414300.6433.57.camel@dyn9047017102.beaverton.ibm.com><20050726151003.6aa3aecb.akpm@osdl.org><1122418089.6433.62.camel@dyn9047017102.beaverton.ibm.com><20050726160728.55245dae.akpm@osdl.org><1122420376.6433.68.camel@dyn9047017102.beaverton.ibm.com><20050726173126.5368266b.akpm@osdl.org><194200000.1122427210@flay> <20050726182631.668e2da2.akpm@osdl.org>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> I don't think so.  We're getting the wrong answer out of
> calculate_zone_totalpages() which is an init-time thing.
> 
> Maybe nr_free_zone_pages() is supposed to fix that up post-facto somehow,
> but calculate_zone_totalpages() sure as heck shouldn't be putting 1568768
> into my ZONE_NORMAL's ->node_present_pages.

Humpf. I'll look at it again later.

nr_free_pagecache_pages -> nr_free_zone_pages -> nr_free_zone_pages

is it not?

M.

