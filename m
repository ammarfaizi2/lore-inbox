Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965111AbWJJIr4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965111AbWJJIr4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 04:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965112AbWJJIr4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 04:47:56 -0400
Received: from ozlabs.org ([203.10.76.45]:3275 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S965111AbWJJIr4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 04:47:56 -0400
Date: Tue, 10 Oct 2006 18:47:48 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Chen@ozlabs.org, Kenneth W <kenneth.w.chen@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Hugepage regression
Message-ID: <20061010084748.GE18681@localhost.localdomain>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Chen@ozlabs.org, Kenneth W <kenneth.w.chen@intel.com>,
	linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems commit fe1668ae5bf0145014c71797febd9ad5670d5d05 causes a
hugepage regression.  A git bisect points the finger at that commit
for causing an oops in the 'alloc-instantiate-race' test from the
libhugetlbfs testsuite.

Still looking to determine the reason it breaks things.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
