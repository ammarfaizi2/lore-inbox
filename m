Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261283AbTDKQhL (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 12:37:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261287AbTDKQhL (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 12:37:11 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:22540
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S261283AbTDKQhK 
	(for <rfc822;linux-kernel@vger.kernel.org>); Fri, 11 Apr 2003 12:37:10 -0400
Subject: Re: Tasklet doubt!
From: Robert Love <rml@tech9.net>
To: root@chaos.analogic.com
Cc: Sriram Narasimhan <nsri@tataelxsi.co.in>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.53.0304111242210.8834@chaos>
References: <3E96EAF5.4060609@tataelxsi.co.in>
	 <Pine.LNX.4.53.0304111242210.8834@chaos>
Content-Type: text/plain
Organization: 
Message-Id: <1050079715.2291.223.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 (1.2.4-2) 
Date: 11 Apr 2003 12:48:36 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-04-11 at 12:46, Richard B. Johnson wrote:

> You only need GFP_ATOMIC for stuff allocated and freed when the
> interrupts are off like in ISRs.

Not just when the interrupts are off but whenever you cannot sleep.

In most interrupt handlers, interrupts are enabled anyhow (except the
current line which is masked out -- but the interrupt system itself is
on i.e. sti is set).  But they cannot sleep.

	Robert Love

