Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263013AbUK0Bvy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263013AbUK0Bvy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 20:51:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262369AbUK0BrO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 20:47:14 -0500
Received: from zeus.kernel.org ([204.152.189.113]:10692 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S263019AbUKZTi1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:38:27 -0500
Subject: Re: PROBLEM: Compatibility problem with C++, i386 & ia64 platform
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Joakim Bentholm XQ (AS/EAB)" <joakim.xq.bentholm@ericsson.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
In-Reply-To: <D6A41B94D27EA643BAE9319F5348603F17D6B3@ESEALNT895.al.sw.ericsson.se>
References: <D6A41B94D27EA643BAE9319F5348603F17D6B3@ESEALNT895.al.sw.ericsson.se>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1101398087.18214.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 25 Nov 2004 15:54:47 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-11-23 at 12:54, Joakim Bentholm XQ (AS/EAB) wrote:
> Maybe the system.h is not supposed to be included outside the kernel?
> Is there a less crude way of getting hold of the macros?

Nobody has really done serious C++ work with the base kernel. Getting
things like interrupt safe C++ memory and exception handling is not
exactly trivial
stuff. As such the kernel isn't really designed to be C++ friendly so
there are various uses of names like "new" in the kernel.

Developing kernel modules with C++ probably isn't ideal but I don't see
any problem in fixing the users of variables like "new" if you want to
do it and submit tested patches to akpm@osdl.org.

Alan

