Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261161AbUCCVlO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 16:41:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261162AbUCCVlO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 16:41:14 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:23747 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261161AbUCCVjt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 16:39:49 -0500
Date: Wed, 03 Mar 2004 13:39:35 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrea Arcangeli <andrea@suse.de>, Dave McCracken <dmccr@us.ibm.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 230-objrmap fixes for 2.6.3-mjb2
Message-ID: <102790000.1078349975@flay>
In-Reply-To: <20040303185122.GV4922@dualathlon.random>
References: <20040303070933.GB4922@dualathlon.random> <20040303025820.2cf6078a.akpm@osdl.org> <7440000.1078328791@[10.10.2.4]> <20040303165746.GO4922@dualathlon.random> <10500000.1078333658@[10.1.1.4]> <20040303183901.GU4922@dualathlon.random> <14140000.1078339447@[10.1.1.4]> <20040303185122.GV4922@dualathlon.random>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> what we do in 2.4 and that works pretty well, that is simply to refile
> pages into the active list if they're mlocked, so we don't waste too
> much cpu on them since we don't analyze them too often. this should work
> pretty well for everybody, or peraphs google may prefer to have a fully
> consistent PG_mlocked.

If the page is actually mlocked, wouldn't it make more sense to remove
it from both the active and inactive lists altogether? Scanning it seems
like it'd be less than fruitful.

M.

