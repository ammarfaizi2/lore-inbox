Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261469AbUCEXd3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 18:33:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261472AbUCEXd3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 18:33:29 -0500
Received: from hera.kernel.org ([63.209.29.2]:38631 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S261469AbUCEXd2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 18:33:28 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: [PATCH] UTF-8ifying the kernel source
Date: Fri, 5 Mar 2004 23:33:20 +0000 (UTC)
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <c2b2o0$cbp$1@terminus.zytor.com>
References: <20040304100503.GA13970@havoc.gtf.org> <20040305232425.GA6239@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1078529600 12666 63.209.29.3 (5 Mar 2004 23:33:20 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Fri, 5 Mar 2004 23:33:20 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20040305232425.GA6239@havoc.gtf.org>
By author:    David Eger <eger@havoc.gtf.org>
In newsgroup: linux.dev.kernel

> The third patch concerns 8-bit characters embedded in C strings.
> These are almost always output to devfs or proc.  The characters used are
> the degrees symbol (for ppc temp. sensors) and mu (for micro-seconds).
> I do not want to make a value judgement on what the kernel outputs
> to userspace, so I leave the strings the same.  However, C99 makes it
> implementation defined how the source character set is translated to
> the character set in the compiled binary...  Therefore, I've taken the
> raw octets and converted them in the source file to octal constants in
> the strings, just to make sure cc doesn't mangle things if you set your
> locale differently...
> 

I would highly vote for making those UTF-8 unless it breaks protocol.

Plain ASCII would be better, though.

	-hpa
