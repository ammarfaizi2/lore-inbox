Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964916AbWGERQk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964916AbWGERQk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 13:16:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964915AbWGERQk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 13:16:40 -0400
Received: from liaag1ad.mx.compuserve.com ([149.174.40.30]:33155 "EHLO
	liaag1ad.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S964916AbWGERQh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 13:16:37 -0400
Date: Wed, 5 Jul 2006 13:12:40 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch] uninline init_waitqueue_*() functions
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>
Message-ID: <200607051314_MC3-1-C43A-5471@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20060705102633.GA17975@elte.hu>

On Wed, 5 Jul 2006 12:26:33 +0200, Ingo Molnar wrote:

> The rough rule of thumb for inlining is that anything that is larger 
> than one C statement is probably too large for inlining. (but even 
> 1-line statements might be too fat at times)

x86-64 software optimization guide says:

 For functions that create fewer than 25 machine instructions once
 inlined, it is likely that the function call overhead is close to,
 or more than, the time spent executing the function body. In these
 cases, function inlining is recommended.

Of course you need to consider whether the code is speed-critical
to begin with.

-- 
Chuck
 "You can't read a newspaper if you can't read."  --George W. Bush
