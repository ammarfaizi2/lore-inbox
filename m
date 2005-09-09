Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751446AbVIINAW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751446AbVIINAW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 09:00:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751447AbVIINAW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 09:00:22 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:37794 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1751446AbVIINAV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 09:00:21 -0400
Date: Fri, 9 Sep 2005 06:00:15 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Linux Memory Management <linux-mm@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.13] lockless pagecache 7/7
In-Reply-To: <4317F203.7060109@yahoo.com.au>
Message-ID: <Pine.LNX.4.62.0509090549110.7332@schroedinger.engr.sgi.com>
References: <4317F071.1070403@yahoo.com.au> <4317F0F9.1080602@yahoo.com.au>
 <4317F136.4040601@yahoo.com.au> <4317F17F.5050306@yahoo.com.au>
 <4317F1A2.8030605@yahoo.com.au> <4317F1BD.8060808@yahoo.com.au>
 <4317F1E2.7030608@yahoo.com.au> <4317F203.7060109@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For Itanium (and I guess also for ppc64 and sparch64) the performance of 
write_lock/unlock is the same as spin_lock/unlock. There is at least 
one case where concurrent reads would be allowed without this patch. 

Maybe keep the rwlock_t there?
