Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261781AbVG2But@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261781AbVG2But (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 21:50:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261838AbVG2But
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 21:50:49 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:17075 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261781AbVG2Bur (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 21:50:47 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.1
From: Keith Owens <kaos@sgi.com>
To: george@mvista.com
cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] NMI watch dog notify patch 
In-reply-to: Your message of "Thu, 28 Jul 2005 13:31:58 MST."
             <42E940BE.3020908@mvista.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 29 Jul 2005 11:50:22 +1000
Message-ID: <4162.1122601822@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jul 2005 13:31:58 -0700, 
George Anzinger <george@mvista.com> wrote:
>I have been doing some work on kgdb to pull a few of it "fingers" out of 
>various places in the kernel.  This is the final location where we have 
>a kgdb intercept not covered by a notify.

I like the idea, but the hook should be in die_nmi(), not in the
watchdog, using the reason that is already passed into die_nmi.
die_nmi() is also called for a real NMI.

