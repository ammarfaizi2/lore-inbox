Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263231AbREaVPm>; Thu, 31 May 2001 17:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263235AbREaVPc>; Thu, 31 May 2001 17:15:32 -0400
Received: from pD9055940.dip.t-dialin.net ([217.5.89.64]:27776 "EHLO fefe.de")
	by vger.kernel.org with ESMTP id <S263231AbREaVPU>;
	Thu, 31 May 2001 17:15:20 -0400
Date: Thu, 31 May 2001 23:15:16 +0200
From: Felix von Leitner <leitner@fefe.de>
To: linux-kernel@vger.kernel.org
Subject: include/asm-sparc/ptrace.h is broken
Message-ID: <20010531231516.A28350@fefe.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

on line 76, it includes <asm/asm_offsets.h>, which does not exist.

This is critical because this include file does not work when used from
a libc.  ptrace.h is from 1997 on my 2.4.5 kernel, so this is not
something that broke recently.

My suggestion is to remove the offending line altogether or at least
protect it with #ifdef __KERNEL__.

Felix
