Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422774AbWHAIQD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422774AbWHAIQD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 04:16:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422773AbWHAIQC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 04:16:02 -0400
Received: from liaag2af.mx.compuserve.com ([149.174.40.157]:4076 "EHLO
	liaag2af.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1422777AbWHAIQA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 04:16:00 -0400
Date: Tue, 1 Aug 2006 04:09:48 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: BUG: unable to handle kernel paging request at virtual
  address
To: Stephen Lynch <Stephen_Lynch@rocketmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200608010412_MC3-1-C6B2-617C@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20060731144810.91843.qmail@web57012.mail.re3.yahoo.com>

On Mon, 31 Jul 2006 07:48:10 -0700 (PDT), Stephen Lynch wrote:

> BUG: unable to handle kernel paging request at virtual address 00080000

Probably a single-bit error, as someone suggested:

  24:   8b 48 28                  mov    0x28(%eax),%ecx
  27:   85 c9                     test   %ecx,%ecx
  29:   74 62                     je     8d <_EIP+0x8d>
   0:   8b 31                     mov    (%ecx),%esi   <=====

It tests for zero and jumps around the failing instruction if that's
true.

-- 
Chuck

