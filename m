Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262012AbTEBJxe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 05:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262014AbTEBJxe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 05:53:34 -0400
Received: from siaab1ab.compuserve.com ([149.174.40.2]:57077 "EHLO
	siaab1ab.compuserve.com") by vger.kernel.org with ESMTP
	id S262012AbTEBJxd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 05:53:33 -0400
Date: Fri, 2 May 2003 06:04:53 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [RFC][PATCH] Faster generic_fls
To: Peter Osterlund <petero2@telia.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200305020605_MC3-1-370C-A9C1@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Osterlund wrote:

>>   mov <mem1>,eax
>>   mov eax,<mem2>
>>   mov <mem1>,eax        ; eax already contains mem1 you stupid compiler
>>   ret
>
> Not necessarily if mem2 == mem1 + 2. Consider this code:

  I realized after sending that last that I should have added that there
were no volatiles and no aliasing possible.  This was the kernel code:

  return conf->last_used = new_disk;

(new_disk is a local variable, conf is a function arg.)

------
 Chuck
