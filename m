Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263365AbUEKS4S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263365AbUEKS4S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 14:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263340AbUEKS4R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 14:56:17 -0400
Received: from fw.osdl.org ([65.172.181.6]:22722 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263380AbUEKS4E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 14:56:04 -0400
Date: Tue, 11 May 2004 11:55:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: Neil Schemenauer <nas@arctrix.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm1
Message-Id: <20040511115539.3c840ebc.akpm@osdl.org>
In-Reply-To: <20040511144918.GA4764@mems-exchange.org>
References: <20040511144918.GA4764@mems-exchange.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Schemenauer <nas@arctrix.com> wrote:
>
> Have you seen my capwrap[1] module?  I wouldn't call it elegant but
>  it is very simple and flexible.

It is.

But if the application which you run does execve(), the capabilties are
dropped.  And if it does setuid() without first doing

	prctl(PR_SET_KEEPCAPS, 1);

then setuid() also drops capabilities.

