Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751159AbWEMOcr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751159AbWEMOcr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 10:32:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751195AbWEMOcr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 10:32:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27583 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751159AbWEMOcq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 10:32:46 -0400
Date: Sat, 13 May 2006 07:29:38 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: chrisw@sous-sol.org, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       ian.pratt@xensource.com, Christian.Limpach@cl.cam.ac.uk
Subject: Re: [RFC PATCH 29/35] Add the Xen virtual console driver.
Message-Id: <20060513072938.642bf600.akpm@osdl.org>
In-Reply-To: <4465D63F.4000605@yahoo.com.au>
References: <20060509084945.373541000@sous-sol.org>
	<20060509085159.285105000@sous-sol.org>
	<20060513052757.59446e03.akpm@osdl.org>
	<4465D63F.4000605@yahoo.com.au>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
> Andrew Morton wrote:
> 
> >>+static void kcons_write_dom0(
> >>+	struct console *c, const char *s, unsigned int count)
> >>+{
> >>+	int rc;
> >>+
> >>+	while ((count > 0) &&
> >>+	       ((rc = HYPERVISOR_console_io(
> >>+			CONSOLEIO_write, count, (char *)s)) > 0)) {
> >>+		count -= rc;
> >>+		s += rc;
> >>+	}
> >>+}
> > 
> > 
> > must.. not.. mention.. coding.. style..
> 
> Someone should write you a script to go through a patch and flag the
> most common style mistakes. Have the output formatted to look like
> you're replying to the mail, and wire it up to your inbox ;)
> 

Even better, someone should write a coding style document, so people get it
right from the outset.

Clever, aren't I?
