Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262845AbTDREHG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 00:07:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262846AbTDREHG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 00:07:06 -0400
Received: from waste.org ([209.173.204.2]:7363 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262845AbTDREHF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 00:07:05 -0400
Date: Thu, 17 Apr 2003 23:18:20 -0500
From: Matt Mackall <mpm@selenic.com>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] only use 48-bit lba when necessary
Message-ID: <20030418041820.GB6645@waste.org>
References: <200304172137_MC3-1-34EB-2D39@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304172137_MC3-1-34EB-2D39@compuserve.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 17, 2003 at 09:34:37PM -0400, Chuck Ebbert wrote:
> Matt Mackall wrote:
> 
> 
> >FYI, GCC as of 3.2.3 doesn't yet reduce the if(...) form to branchless
> >code but the & and && versions come out the same with -O2.
> 
>   The operands of & can be evaluated in any order, while && requires
> left-to-right and does not evaluate the right operand if the left one
> is false.  Only the simplest cases could possibly generate the same
> code.

Actually, any where the arguments to && are already boolean (pretty
common) and have no side effects (pretty common) will be equivalent
and could very well result in the same code. Only the simplest cases
are interesting anyway, otherwise the branchless & obfuscation is a
loss due to extra evaluation.

-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon
