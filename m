Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262710AbTDRB0H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 21:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262726AbTDRB0H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 21:26:07 -0400
Received: from siaag2ab.compuserve.com ([149.174.40.132]:36801 "EHLO
	siaag2ab.compuserve.com") by vger.kernel.org with ESMTP
	id S262710AbTDRB0G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 21:26:06 -0400
Date: Thu, 17 Apr 2003 21:34:37 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH] only use 48-bit lba when necessary
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200304172137_MC3-1-34EB-2D39@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall wrote:


>FYI, GCC as of 3.2.3 doesn't yet reduce the if(...) form to branchless
>code but the & and && versions come out the same with -O2.


  The operands of & can be evaluated in any order, while && requires
left-to-right and does not evaluate the right operand if the left one
is false.  Only the simplest cases could possibly generate the same
code.

--
 Chuck
