Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268028AbUJDLsX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268028AbUJDLsX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 07:48:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268026AbUJDLsX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 07:48:23 -0400
Received: from open.hands.com ([195.224.53.39]:13476 "EHLO open.hands.com")
	by vger.kernel.org with ESMTP id S268028AbUJDLsU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 07:48:20 -0400
Date: Mon, 4 Oct 2004 12:59:26 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: linux-kernel@vger.kernel.org
Subject: allocating user-memory from kernel: do i use GFP_USER
Message-ID: <20041004115926.GD19341@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-hands-com-MailScanner-SpamScore: s
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi, it occurred to me that instead of cut/paste all the sys_* functions
in fs/*.c for this proxyfs kernel module i am doing that i could
instead, if i could get hold of some user memory, call the sys_*
functions directly.

can i just do this:

	char __user *filename = kmalloc(strlen(kfilename)+1, GFP_USER);

and then this:

	sys_rename(filename, ...);

and expect it to work?

ta,

l.

-- 
--
Truth, honesty and respect are rare commodities that all spring from
the same well: Love.  If you love yourself and everyone and everything
around you, funnily and coincidentally enough, life gets a lot better.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />

