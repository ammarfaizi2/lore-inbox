Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261193AbVGGGwp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbVGGGwp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 02:52:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261205AbVGGGuO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 02:50:14 -0400
Received: from [194.90.79.130] ([194.90.79.130]:11538 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S261193AbVGGGta (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 02:49:30 -0400
Subject: Re: RFC: Hugepage COW
From: Avi Kivity <avi@argo.co.il>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org
In-Reply-To: <20050707055554.GC11246@localhost.localdomain>
References: <20050707055554.GC11246@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 07 Jul 2005 09:49:27 +0300
Message-Id: <1120718967.2989.7.camel@blast.q>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Jul 2005 06:49:29.0120 (UTC) FILETIME=[05B7F200:01C582C0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-07-07 at 15:55 +1000, David Gibson wrote:

> MAP_PRIVATE|MAP_WRITE mappings of hugetlbfs.  Because the pool of
> hugepages is limited, a write to a MAP_PRIVATE hugepage region may
> result in a SIGBUS, if a new hugepage cannot be allocated.  This patch

in that case you might allocate regular pages for the new copy.

