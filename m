Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262254AbVDFQi7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262254AbVDFQi7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 12:38:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262253AbVDFQi7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 12:38:59 -0400
Received: from az33egw02.freescale.net ([192.88.158.103]:58786 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S262249AbVDFQiv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 12:38:51 -0400
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Transfer-Encoding: 7bit
Message-Id: <a0b2cb42ff815dcf964b7a728f638b87@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
To: LKML list <linux-kernel@vger.kernel.org>
From: Kumar Gala <kumar.gala@freescale.com>
Subject: return value of ptep_get_and_clear
Date: Wed, 6 Apr 2005 11:38:48 -0500
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ptep_get_and_clear has a signature that looks something like:

static inline pte_t ptep_get_and_clear(struct mm_struct *mm, unsigned 
long addr,
                                        pte_t *ptep)

It appears that its suppose to return the pte_t pointed to by ptep 
before its modified.  Why do we bother doing this?  The caller seems 
perfectly able to dereference ptep and hold on to it.  Am I missing 
something here?

If not, I'll work up a set of patches to change ptep_get_and_clear and 
its callers for post 2.6.12 release.

- kumar

