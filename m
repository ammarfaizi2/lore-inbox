Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131973AbRCYMvX>; Sun, 25 Mar 2001 07:51:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131978AbRCYMvN>; Sun, 25 Mar 2001 07:51:13 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:41481 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S131973AbRCYMvI>;
	Sun, 25 Mar 2001 07:51:08 -0500
Date: Sun, 25 Mar 2001 13:50:25 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org
Subject: 2.4.3-pre7 and p*_alloc
Message-ID: <20010325135025.A30655@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm looking at re-implementing the ARM page table allocation macros
required for 2.4.3-pre7, and have found the following:

pte_t *pte_alloc(struct mm_struct *mm, pmd_t *pmd, unsigned long address)
{
	if (!pmd_present(*pmd)) {

Why do we use pmd_present here instead of pmd_none?  The same question
applies to __pmd_alloc.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

