Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264255AbTEGT30 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 15:29:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264259AbTEGT3Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 15:29:25 -0400
Received: from siaab1ab.compuserve.com ([149.174.40.2]:9646 "EHLO
	siaab1ab.compuserve.com") by vger.kernel.org with ESMTP
	id S264255AbTEGT2r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 15:28:47 -0400
Date: Wed, 7 May 2003 15:38:19 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: top stack (l)users for 2.5.69
To: "root@chaos.analogic.com" <root@chaos.analogic.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200305071540_MC3-1-37DD-34B0@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Every time you switch to kernel mode either by
> calling the kernel or by a hardware interrupt, the kernel's stack
> is used.

  Almost correct: it's _a_ kernel stack, not _the_ kernel stack.

  The load_esp0() function changes this on every task switch on
i386.  If there were only one kernel stack then there would be no
need to ever do that...
