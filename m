Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267523AbUIJQDd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267523AbUIJQDd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 12:03:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267497AbUIJP75
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 11:59:57 -0400
Received: from main.gmane.org ([80.91.224.249]:27626 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S267523AbUIJP6o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 11:58:44 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Subject: Re: [PATCH 1/3] Separate IRQ-stacks from 4K-stacks option
Date: Fri, 10 Sep 2004 21:58:52 +0600
Message-ID: <chsivd$827$1@sea.gmane.org>
References: <20040909232532.GA13572@taniwha.stupidest.org> <1094798428.2800.3.camel@laptop.fenrus.com> <1094807650.17041.3.camel@localhost.localdomain> <593560000.1094826651@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: dsa.physics.usu.ru
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040121
X-Accept-Language: en-us, en
In-Reply-To: <593560000.1094826651@[10.10.2.4]>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
> --Alan Cox <alan@lxorguk.ukuu.org.uk> wrote (on Friday, September 10, 2004 10:14:11 +0100):
>>Its probably appropriate to drop gcc 2.x support at that point too since
>>it's the major cause of remaining problems
> 
> What problems does it cause? 2.95.4 still seems to work fine for me.

The latest gcc2 on the ftp.gnu.org site is gcc 2.95.3. There is 
officially no such thing as "gcc 2.95.4". Probably you are talking about 
a patched version of some gcc2 cvs snapshot - that's what distros 
provide. Please specify exactly what gcc version you are talking about.

And there _is_ problem with gcc-2.95.3-compiled kernel: latest cvs glibc 
testsuite segfaults in nptl tests. There are no failures with the kernel 
identically configured, but compiled with gcc 3.3.4 or 3.4.1. So gcc 
2.95.3 as supplied by gnu.org miscompiles the kernel (futexes?). Either 
fix the kernel or drop gcc2 support.

-- 
Alexander E. Patrakov

