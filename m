Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932508AbWCMWPz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932508AbWCMWPz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 17:15:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932506AbWCMWPm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 17:15:42 -0500
Received: from smtp.osdl.org ([65.172.181.4]:5265 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932508AbWCMWPi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 17:15:38 -0500
Date: Mon, 13 Mar 2006 14:13:05 -0800
From: Andrew Morton <akpm@osdl.org>
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: ioe-lkml@rameria.de, davem@davemloft.net, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [PATCH] scm: fold __scm_send() into scm_send()
Message-Id: <20060313141305.0cd4fe97.akpm@osdl.org>
In-Reply-To: <20060313202242.GC27761@kvack.org>
References: <200603130139.k2D1dpSQ021279@shell0.pdx.osdl.net>
	<20060312.180802.13404061.davem@davemloft.net>
	<200603132105.32794.ioe-lkml@rameria.de>
	<20060313202242.GC27761@kvack.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise <bcrl@kvack.org> wrote:
>
> On Mon, Mar 13, 2006 at 09:05:31PM +0100, Ingo Oeser wrote:
> > From: Ingo Oeser <ioe-lkml@rameria.de>
> > 
> > Fold __scm_send() into scm_send() and remove that interface completly
> > from the kernel.
> 
> Whoa, what are you doing here?
>

scm_send() and scm_recv() are already uninlined in Dave's tree - this patch
does further consolidation.

>  Uninlining scm_send() is a Bad Thing to do 
> given that scm_send() is in the AF_UNIX hot path.

scm_send() and scm_recv() are in _two_ AF_UNIX hotpaths...

