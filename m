Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262671AbTEOFaL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 01:30:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263340AbTEOFaL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 01:30:11 -0400
Received: from pizda.ninka.net ([216.101.162.242]:34721 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262671AbTEOFaK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 01:30:10 -0400
Date: Wed, 14 May 2003 22:42:14 -0700 (PDT)
Message-Id: <20030514.224214.42791773.davem@redhat.com>
To: jmorris@intercode.com.au
Cc: alex14641@yahoo.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: link error building kernel with gcc-3.3
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Mutt.LNX.4.44.0305151536280.12417-100000@excalibur.intercode.com.au>
References: <20030514202941.39519.qmail@web40503.mail.yahoo.com>
	<Mutt.LNX.4.44.0305151536280.12417-100000@excalibur.intercode.com.au>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: James Morris <jmorris@intercode.com.au>
   Date: Thu, 15 May 2003 15:38:15 +1000 (EST)
   
   I wonder, does this mean that the compiler failed to inline the function?
   
   Removing __inline__ is not the correct solution.
   
I already posted what the correct fix is :-)  And this is already
pushed to 2.5.x

Inlining is not guarenteed, and:

extern inline ... foo(...)

means "inline if you can, I have a compiled-in implementation
in some object somewhere" whereas:

static inline ... foo(...)

means "inline if you can, if there is a case where you cannot
emit this as a function into the current module"
