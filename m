Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268097AbUI1Xkn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268097AbUI1Xkn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 19:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268100AbUI1Xkn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 19:40:43 -0400
Received: from open.hands.com ([195.224.53.39]:54737 "EHLO open.hands.com")
	by vger.kernel.org with ESMTP id S268097AbUI1Xkl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 19:40:41 -0400
Date: Wed, 29 Sep 2004 00:51:47 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: linux-kernel@vger.kernel.org
Subject: "fs proxy" module - how to turn path into dev+inode
Message-ID: <20040928235147.GE6287@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-hands-com-MailScanner-SpamScore: s
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

for various reasons i am going to have to start on an fsproxy module.

if i use d_path() to get the full pathname of an inode in the fsproxy
filesystem, and then i prepend that path with the proxy prefix which
specifies the _real_ location:

how do i then turn that full pathname _back_ into a vfsmount and a
dentry?

how about.... user_path_walk() used in fs/open.c?  is that it?

*glurk*.  7 types of chaos...

-- 
--
Truth, honesty and respect are rare commodities that all spring from
the same well: Love.  If you love yourself and everyone and everything
around you, funnily and coincidentally enough, life gets a lot better.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />

