Return-Path: <linux-kernel-owner+w=401wt.eu-S964823AbWL1AGP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964823AbWL1AGP (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 19:06:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964834AbWL1AGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 19:06:15 -0500
Received: from homer.mvista.com ([63.81.120.158]:9863 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S964823AbWL1AGO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 19:06:14 -0500
Subject: Re: [PATCH -rt] update kmap_atomic on !HIGHMEM
From: Daniel Walker <dwalker@mvista.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061227212555.GA14947@elte.hu>
References: <20061227193550.324850000@mvista.com>
	 <20061227212555.GA14947@elte.hu>
Content-Type: text/plain
Date: Wed, 27 Dec 2006 16:05:30 -0800
Message-Id: <1167264330.14081.54.camel@imap.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-12-27 at 22:25 +0100, Ingo Molnar wrote:
> * Daniel Walker <dwalker@mvista.com> wrote:
> 
> > I got some scheduling while atomic on x86-64 , and since x86-64 
> > doesn't seem to have HIGHMEM there's no workaround for kmap_atomic() .
> > 
> > This patch adds the same as i386 HIGHMEM for !HIGHMEM.
> 
> the problem is that this does not disable pagefaulting while 
> kmap-atomic. Could you try the patch below, does it solve the assert?
> 


It hasn't crashed after about an hour of stress.. One comment on the
patch tho , the pagefault_enable/pagefault_disable need module exports,
I saw the build complaining about them.

Daniel

