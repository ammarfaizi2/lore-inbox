Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264389AbTDKQUC (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 12:20:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264418AbTDKQUC (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 12:20:02 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:29963
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S264389AbTDKQUB 
	(for <rfc822;linux-kernel@vger.kernel.org>); Fri, 11 Apr 2003 12:20:01 -0400
Subject: Re: Tasklet doubt!
From: Robert Love <rml@tech9.net>
To: Sriram Narasimhan <nsri@tataelxsi.co.in>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3E96EAF5.4060609@tataelxsi.co.in>
References: <3E96EAF5.4060609@tataelxsi.co.in>
Content-Type: text/plain
Organization: 
Message-Id: <1050078702.2291.218.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 (1.2.4-2) 
Date: 11 Apr 2003 12:31:42 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-04-11 at 12:19, Sriram Narasimhan wrote:

> How much of memory can be allocated from a tasklet ? [ kmalloc 
> (GFP_ATOMIC) ].

It depends.  Asking for 2.5MB of GFP_ATOMIC is a lot.

Perhaps you should use the keventd task queue, which runs in process
context and thus sleeps.  You can allocate using kmalloc(GFP_KERNEL) or
even vmalloc().

	Robert Love

