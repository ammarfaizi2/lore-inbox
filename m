Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262384AbRE2XBP>; Tue, 29 May 2001 19:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262389AbRE2XBF>; Tue, 29 May 2001 19:01:05 -0400
Received: from pizda.ninka.net ([216.101.162.242]:59037 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262384AbRE2XAv>;
	Tue, 29 May 2001 19:00:51 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15124.10785.10143.242660@pizda.ninka.net>
Date: Tue, 29 May 2001 16:00:49 -0700 (PDT)
To: Dawson Engler <engler@csl.Stanford.EDU>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] 4 security holes in 2.4.4-ac8
In-Reply-To: <200105292257.PAA00192@csl.Stanford.EDU>
In-Reply-To: <15124.7615.678503.824814@pizda.ninka.net>
	<200105292257.PAA00192@csl.Stanford.EDU>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dawson Engler writes:
 > Ah.  I assumed that "sys_*" meant that all pointers were from user space ---
 > is this generally not the case?

This shared memory syscall is just a weird exception.

 > (Also, are there other functions called 
 > directly from user space that don't have the sys_* prefix?)

Almost certainly, arch/i386/mm/fault.c:do_page_fault is one of
many examples.

Later,
David S. Miller
davem@redhat.com
