Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268978AbUJELVy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268978AbUJELVy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 07:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268985AbUJELVy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 07:21:54 -0400
Received: from main.gmane.org ([80.91.229.2]:51154 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S268978AbUJELVB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 07:21:01 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Richard Earnshaw <richard.earnshaw@arm.com>
Subject: Re: [RFC] ARM binutils feature churn causing kernel problems
Date: Tue, 5 Oct 2004 11:10:46 +0000 (UTC)
Message-ID: <loom.20041005T130541-400@post.gmane.org>
References: <20040927210305.A26680@flint.arm.linux.org.uk>  <20041001211106.F30122@flint.arm.linux.org.uk>  <tnxllemvgi7.fsf@arm.com> <1096931899.32500.37.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 193.131.176.54 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040207 Firefox/0.8)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell <rusty <at> rustcorp.com.au> writes:
> Russell, I thought about not including any symbol which is not of form
> "[A-Za-z0-9_]+" in kallsyms, for all archs: you are not the only one
> with weird-ass symbols.  Is it that you want these mapping symbols in
> /proc/kallsyms but ignored in backtraces, or you don't need them in
> kallsyms altogether?
> 
> Thanks,
> Rusty.


Mapping symbols will always be encoded with STB_LOCAL and STT_NOTYPE.  I would
have thought it unlikely that the kernel would ever want to report against any
symbol with those attributes and they could all be dropped on that basis.

R.

