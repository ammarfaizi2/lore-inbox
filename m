Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932252AbWGXRv3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932252AbWGXRv3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 13:51:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932254AbWGXRvO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 13:51:14 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:62183 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932252AbWGXRvI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 13:51:08 -0400
Subject: [RFC][PATCH 0/6] Integrity Service and SLIM
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: linux-kernel <linux-kernel@vger.kernel.org>,
       LSM ML <linux-security-module@vger.kernel.org>
Cc: Dave Safford <safford@us.ibm.com>, Mimi Zohar <zohar@us.ibm.com>,
       Serge Hallyn <sergeh@us.ibm.com>
Content-Type: text/plain
Date: Mon, 24 Jul 2006 10:51:12 -0700
Message-Id: <1153763472.5171.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an updated request for comments on a proposed integrity 
service framework and dummy provider, along with SLIM, a low 
water-mark mandatory access control LSM module which utilizes the 
integrity services as additional input to the access control decisions.

The latest fixes include:
	- SLIM: Locking overhaul
	- All: Update to 2.6.18-rc1 kernel

Later we will be submitting EVM as a specific integrity service
provider under this proposed framework. By separating the submissions,
we hope that the integrity framework and its relationship to SLIM
(and potentially to selinux) will be clearer and easier to review.
Since this integrity provider is a dummy, it has no requirements for
TPM hardware, or for LSM stacking, again making the review simpler.

A corresponding userspace utility package is available at
http://www.research.ibm.com/gsal/tcpa

Patch 1/6 is a tiny patch to make mprotect available for revocation

Patch 2/6 provides the integrity service API with dummy provider.

Patch 3-6 provide SLIM, and a more detailed description of
its changes, and points out its use of the integrity service.

These patches have no prerequisites for stacker or TPM related patches.


