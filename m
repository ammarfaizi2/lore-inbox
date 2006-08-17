Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030212AbWHQTww@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030212AbWHQTww (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 15:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030208AbWHQTwv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 15:52:51 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:46484 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030207AbWHQTwu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 15:52:50 -0400
Subject: [RFC][PATCH 0/8] Integrity Service and SLIM
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: linux-kernel <linux-kernel@vger.kernel.org>,
       LSM ML <linux-security-module@vger.kernel.org>
Cc: Dave Safford <safford@us.ibm.com>, Mimi Zohar <zohar@us.ibm.com>,
       Serge Hallyn <sergeh@us.ibm.com>
Content-Type: text/plain
Date: Thu, 17 Aug 2006 12:52:59 -0700
Message-Id: <1155844379.6788.54.camel@localhost.localdomain>
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

Patch 1/8 is a tiny patch to make mprotect available for revocation.

Patch 2/8 provides the integrity service API with dummy provider.

Patch 3/8 provieds a new hook for initilizing the security pointer of the init_task.

Patch 4-8 provide SLIM, and a more detailed description of
its changes, and points out its use of the integrity service.

These patches have no prerequisites for stacker or TPM related patches.


