Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261432AbVCGMLd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261432AbVCGMLd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 07:11:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261451AbVCGMLd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 07:11:33 -0500
Received: from fire.osdl.org ([65.172.181.4]:36564 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261432AbVCGML3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 07:11:29 -0500
Date: Mon, 7 Mar 2005 04:10:47 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, davidm@snapgear.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] BDI: Provide backing device capability information
Message-Id: <20050307041047.59c24dec.akpm@osdl.org>
In-Reply-To: <9947.1110196314@redhat.com>
References: <20050307034747.4c6e7277.akpm@osdl.org>
	<20050307033734.5cc75183.akpm@osdl.org>
	<20050303123448.462c56cd.akpm@osdl.org>
	<20050302135146.2248c7e5.akpm@osdl.org>
	<20050302090734.5a9895a3.akpm@osdl.org>
	<9420.1109778627@redhat.com>
	<31789.1109799287@redhat.com>
	<13767.1109857095@redhat.com>
	<9268.1110194624@redhat.com>
	<9741.1110195784@redhat.com>
	<9947.1110196314@redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:
>
> Andrew Morton <akpm@osdl.org> wrote:
> 
> > > Any particular reason? It's mixed in with other unsigned longs and pointers
> > > after all...
> > 
> > Just that it's the natural wordsize of the machine, and uses less storage.
> 
> Making it unsigned long on a 32-bit machine will make no difference. Making it
> unsigned int on a 64-bit machine will waste four bytes.
> 

No, it won't waste any bytes at all.  It won't save any either.

But if someone comes along later and wants to add another int to that
structure, they won't know that your field was needlessly made a long, and
they'll then waste another eight bytes.

