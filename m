Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751915AbWFUBTG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751915AbWFUBTG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 21:19:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932413AbWFUBTG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 21:19:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51856 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751917AbWFUBTD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 21:19:03 -0400
Date: Tue, 20 Jun 2006 18:18:56 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: serue@us.ibm.com, linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: Re: [PATCH] kthread: convert stop_machine into a kthread
Message-Id: <20060620181856.df8afa60.akpm@osdl.org>
In-Reply-To: <20060621005206.GA24600@sergelap.austin.ibm.com>
References: <20060615144331.GB16046@sergelap.austin.ibm.com>
	<20060619201450.3434f72f.akpm@osdl.org>
	<20060620082745.GA28092@sergelap>
	<20060620014027.eba58cb7.akpm@osdl.org>
	<20060620162706.GB21542@sergelap.austin.ibm.com>
	<20060620154241.024ad134.akpm@osdl.org>
	<20060621005206.GA24600@sergelap.austin.ibm.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jun 2006 19:52:06 -0500
"Serge E. Hallyn" <serue@us.ibm.com> wrote:

> here's
> the patch I meant to send.
> 
> ...
>
> -static int stopmachine(void *cpu)
> +static int stopmachine(void)
> ...
> -		tsk = kthread_run(stopmachine, (void *)(long)i, "stopmachine");
> +		tsk = kthread_create(stopmachine, NULL, "stopmachine");

This should have spat a compiler warning.

The confidence level on all of this ain't high.  Please, test the patch
which I merged?
