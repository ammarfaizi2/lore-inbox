Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268336AbUGXGyc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268336AbUGXGyc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jul 2004 02:54:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268337AbUGXGyc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jul 2004 02:54:32 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:6871 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S268336AbUGXGyb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jul 2004 02:54:31 -0400
Date: Fri, 23 Jul 2004 23:53:01 -0700
From: Paul Jackson <pj@sgi.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: rml@ximian.com, da-x@gmx.net, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] kernel events layer
Message-Id: <20040723235301.3a06151b.pj@sgi.com>
In-Reply-To: <4956.1090644161@ocs3.ocs.com.au>
References: <1090637226.1830.8.camel@localhost>
	<4956.1090644161@ocs3.ocs.com.au>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith wrote:
> Never use the return value from snprintf to work out the next buffer
> position, it is not reliable when the data is truncated.

That's why Juergen Quade added scnprintf and vscnprintf to lib/vsprintf.c:

 * If you want to have the exact
 * number of characters written into @buf as return value
 * (not including the trailing '\0'), use vscnprintf.

Andrew wrote:
> A single snprintf here would suit.

As Robert said ... Doh!

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
