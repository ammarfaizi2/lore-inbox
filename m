Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750991AbVIFVxf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991AbVIFVxf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 17:53:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750992AbVIFVxf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 17:53:35 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:5304 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750990AbVIFVxf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 17:53:35 -0400
Subject: [PATCH 0/3] Demand faulting for hugetlb
From: Adam Litke <agl@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: "ADAM G. LITKE [imap]" <agl@us.ibm.com>
Content-Type: text/plain
Organization: IBM
Date: Tue, 06 Sep 2005 16:53:31 -0500
Message-Id: <1126043611.3123.55.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am sending out the latest set of patches for hugetlb demand faulting.
I've incorporated all the feedback I've received from previous
discussions and I think this is ready for some more widespread testing.
Is anyone opposed to spinning this in -mm as it stands?

The three patches:
 1) Remove a get_user_pages() optimization that is no longer valid for
demand faulting
 2) Move fault logic from hugetlb_prefault() to hugetlb_pte_fault()
 3) Apply a simple overcommit check so demand fault accounting behaves
in a manner in line with how prefault worked

Diffed against 2.6.13-git6

