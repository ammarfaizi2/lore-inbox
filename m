Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751600AbVIZIF7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751600AbVIZIF7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 04:05:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751605AbVIZIF6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 04:05:58 -0400
Received: from gate.crashing.org ([63.228.1.57]:36287 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751600AbVIZIF6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 04:05:58 -0400
Subject: Re: update_mmu_cache(): fault or not fault ?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linux-mm@kvack.org
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <1127715725.15882.43.camel@gaston>
References: <1127715725.15882.43.camel@gaston>
Content-Type: text/plain
Date: Mon, 26 Sep 2005 18:05:23 +1000
Message-Id: <1127721923.15882.67.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> So I suggest adding an argument to it "int is_fault", that would
> basically be '1' on all the call sites in mm/memory.c and '0' in all the
> call sites in mm/fremap.c.
> 
> Any objection, comment, whatever, before I come up with a patch adding
> it to all archs ?

Acutally, that wouldn't work for calls to get_user_pages() which will
cause the fault code path on non-faults... looks like David's solution
is the best one at this point.

Ben.


