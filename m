Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262599AbVC3Xox@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262599AbVC3Xox (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 18:44:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262598AbVC3Xox
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 18:44:53 -0500
Received: from fire.osdl.org ([65.172.181.4]:17315 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262597AbVC3Xok (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 18:44:40 -0500
Date: Wed, 30 Mar 2005 15:44:44 -0800
From: Andrew Morton <akpm@osdl.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] Add support for semaphore-like structure with support for
 asynchronous I/O
Message-Id: <20050330154444.02da9765.akpm@osdl.org>
In-Reply-To: <1112224663.18019.39.camel@lade.trondhjem.org>
References: <1112219491.10771.18.camel@lade.trondhjem.org>
	<20050330143409.04f48431.akpm@osdl.org>
	<1112224663.18019.39.camel@lade.trondhjem.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
>
> This is required in order to allow threads such as rpciod or keventd
> itself (for which sleeping may cause deadlocks) to ask the iosem manager
> code to simply queue the work that need to run once the iosem has been
> granted. That work function is then, of course, responsible for
> releasing the iosem when it is done.

I see.  I think.  Should we be using those aio/N threads for this?  They
don't seem to do much else...

