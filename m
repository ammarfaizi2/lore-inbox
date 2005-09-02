Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751382AbVIBXxb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751382AbVIBXxb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 19:53:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751383AbVIBXxa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 19:53:30 -0400
Received: from hera.kernel.org ([209.128.68.125]:59570 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1751382AbVIBXxa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 19:53:30 -0400
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: [RFC] Splitting out kernel<=>userspace ABI headers
Date: Fri, 2 Sep 2005 23:53:09 +0000 (UTC)
Organization: Mostly alphabetical, except Q, which We do not fancy
Message-ID: <dfaol5$da0$1@terminus.zytor.com>
References: <C670AD22-97CF-46AA-A527-965036D78667@mac.com> <9F74838E-651D-4952-BD7C-63B09D76F743@mac.com> <4318DF26.5060707@zytor.com> <76E84FF2-A76E-4114-8E80-E07E6A497C7D@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1125705189 13633 127.0.0.1 (2 Sep 2005 23:53:09 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Fri, 2 Sep 2005 23:53:09 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <76E84FF2-A76E-4114-8E80-E07E6A497C7D@mac.com>
By author:    Kyle Moffett <mrmacman_g4@mac.com>
In newsgroup: linux.dev.kernel
> 
> The kernel already needs those same optimized routines for its own
> operation (EX: all the ASM alternative() statements).  Since userspace
> wants some of those as well, it would make sense to share them between
> kernel and userspace and reduce the number of libraries you would need
> to optimize when adding a new arch.  I don't think that we should add
> optimized assembly for things that _aren't_ needed in the kernel, but
> it should share what code it does have.
> 
> A side benefit of the vDSO method is that you would be able to take a
> standard distro install and have the kernel automatically select the
> correct vDSO image at runtime, simultaneously optimizing itself and
> chunks of userspace.
> 

First of all, a lot of these are inlines, and they derive a chunk of
their benefit from being inline.  Second, even if bundled with the
kernel, which I'm not sure is wise, there is no reason they can't just
be turned into libraries.  *Some functions* you're right, can be
optimized this way, but I'm not sure if that justifies compiling them
into the kernel that way.

	-hpa
