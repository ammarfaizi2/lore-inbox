Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261379AbVCGLwS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261379AbVCGLwS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 06:52:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261408AbVCGLwS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 06:52:18 -0500
Received: from mx1.redhat.com ([66.187.233.31]:20394 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261379AbVCGLwP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 06:52:15 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20050307034747.4c6e7277.akpm@osdl.org> 
References: <20050307034747.4c6e7277.akpm@osdl.org>  <20050307033734.5cc75183.akpm@osdl.org> <20050303123448.462c56cd.akpm@osdl.org> <20050302135146.2248c7e5.akpm@osdl.org> <20050302090734.5a9895a3.akpm@osdl.org> <9420.1109778627@redhat.com> <31789.1109799287@redhat.com> <13767.1109857095@redhat.com> <9268.1110194624@redhat.com> <9741.1110195784@redhat.com> 
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, davidm@snapgear.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] BDI: Provide backing device capability information 
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.1
Date: Mon, 07 Mar 2005 11:51:54 +0000
Message-ID: <9947.1110196314@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:

> > Any particular reason? It's mixed in with other unsigned longs and pointers
> > after all...
> 
> Just that it's the natural wordsize of the machine, and uses less storage.

Making it unsigned long on a 32-bit machine will make no difference. Making it
unsigned int on a 64-bit machine will waste four bytes.

David
