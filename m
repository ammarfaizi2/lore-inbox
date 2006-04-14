Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965117AbWDNI1r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965117AbWDNI1r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 04:27:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751223AbWDNI1r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 04:27:47 -0400
Received: from iona.labri.fr ([147.210.8.143]:37528 "EHLO iona.labri.fr")
	by vger.kernel.org with ESMTP id S1751203AbWDNI1q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 04:27:46 -0400
Date: Fri, 14 Apr 2006 10:28:09 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Subject: __cmpxchg_u64 and llsc/LLSC_WAR
Message-ID: <20060414082809.GA4283@implementation.labri.fr>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In linux/include/asm-mips/system.h:__cmpxchg_u64(), one can read

	if (cpu_has_llsc) {
		asm(stuff with beqzl);
	} else if (cpu_has_llsc) {
		asm(stuff with beqz);
	} else {
		C code;
	}

There's no test for "LLSC_WAR", is that on purpose? (i.e.. is beqzl
always needed rather than beqz?)

Regards,
Samuel
