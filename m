Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932134AbVJDDjI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932134AbVJDDjI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 23:39:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932136AbVJDDjH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 23:39:07 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:38319 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932134AbVJDDjG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 23:39:06 -0400
Date: Mon, 3 Oct 2005 20:38:26 -0700
From: Paul Jackson <pj@sgi.com>
To: Magnus Damm <magnus.damm@gmail.com>
Cc: torvalds@osdl.org, akpm@osdl.org, jgarzik@pobox.com, rdunlap@xenotime.net,
       linux-kernel@vger.kernel.org, coywolf@gmail.com, greg@kroah.com
Subject: Re: [PATCHv2] Document from line in patch format
Message-Id: <20051003203826.514ea047.pj@sgi.com>
In-Reply-To: <aec7e5c30510032024t6d48643fma875c917acb69d92@mail.gmail.com>
References: <20051002163244.17502.15351.sendpatchset@jackhammer.engr.sgi.com>
	<Pine.LNX.4.64.0510021158260.31407@g5.osdl.org>
	<aec7e5c30510032024t6d48643fma875c917acb69d92@mail.gmail.com>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Magnus wrote:
> Huh, I thought that the first line in a unified patch started with
> "---",

Yes, it does.  But then the next character is a space, and there
is at least one more space-separated field on the line.

That is, Linus's marker marches

    /^---$/

and the first line of a unified patch matches:

    /^--- .*[^ ].*$/

It ain't fancy, but it works.  These patterns
are easily distinguished.

> Relying on "diff -" or "Index: " seems wrong.

I don't think anyone is relying on those patterns.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
