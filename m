Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263130AbTEBWf0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 18:35:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263192AbTEBWf0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 18:35:26 -0400
Received: from siaab2ab.compuserve.com ([149.174.40.130]:35992 "EHLO
	siaab2ab.compuserve.com") by vger.kernel.org with ESMTP
	id S263130AbTEBWfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 18:35:25 -0400
Date: Fri, 2 May 2003 18:46:20 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [Announcement] "Exec Shield", new Linux security feature
To: John Bradford <john@grabjohn.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200305021847_MC3-1-3725-A1B@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Bradford wrote:

> Slightly off-topic, but does anybody know whether IA64 or x86-64 allow
> you to make the stack non-executable in the same way you can on SPARC?

 IA64 supports a mind-boggling variety of page-level protection modes,
including execute-only pages that usermode can jump to and get
'promoted' to lower (more privileged) levels.  _And_ it supports
protection keys that can be attached to pages so your process needs
to have the key loaded into a register to touch those pages.  The keys
can themselves be marked read/write/execute disable on loading, so
the supervisor can give you a key that keeps you from executing pages
even if their page-level protections would otherwise allow it.

 AMD64 supports a simple NX (no execute) bit that keeps both supervisor
and user code from executing, and that's probably all anyone really needs.

------
 Chuck
