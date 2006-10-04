Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751138AbWJDVby@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751138AbWJDVby (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 17:31:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751146AbWJDVby
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 17:31:54 -0400
Received: from taverner.CS.Berkeley.EDU ([128.32.168.222]:53132 "EHLO
	taverner.cs.berkeley.edu") by vger.kernel.org with ESMTP
	id S1751138AbWJDVby (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 17:31:54 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: [patch] remove MNT_NOEXEC check for PROT_EXEC mmaps
Date: Wed, 4 Oct 2006 21:31:43 +0000 (UTC)
Organization: University of California, Berkeley
Message-ID: <eg197v$e0c$1@taverner.cs.berkeley.edu>
References: <45150CD7.4010708@aknet.ru> <4522BCBF.2050508@aknet.ru> <1159905265.2891.551.camel@laptopd505.fenrus.org> <45240D4E.7090500@aknet.ru>
Reply-To: daw-usenet@taverner.cs.berkeley.edu (David Wagner)
NNTP-Posting-Host: taverner.cs.berkeley.edu
X-Trace: taverner.cs.berkeley.edu 1159997503 14348 128.32.168.222 (4 Oct 2006 21:31:43 GMT)
X-Complaints-To: news@taverner.cs.berkeley.edu
NNTP-Posting-Date: Wed, 4 Oct 2006 21:31:43 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: daw@taverner.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stas Sergeev  wrote:
>The primary goal is to make access() to respect the "noexec".

Unfortunately, access() is insecure by design -- it is inherently
susceptible to race conditions (TOCTTOU attacks).  Therefore, I don't
think it is useful for enforcing security restrictions (such as
enforcing noexec in ld.so).
