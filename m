Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261886AbVFUD1B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261886AbVFUD1B (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 23:27:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261714AbVFUD00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 23:26:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:33237 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261886AbVFUCft (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 22:35:49 -0400
Date: Mon, 20 Jun 2005 19:35:20 -0700
From: Andrew Morton <akpm@osdl.org>
To: James Morris <jmorris@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: -mm patch glut
Message-Id: <20050620193520.03535d9b.akpm@osdl.org>
In-Reply-To: <Xine.LNX.4.44.0506202226040.18916-100000@thoron.boston.redhat.com>
References: <20050620173549.6d064fe7.akpm@osdl.org>
	<Xine.LNX.4.44.0506202226040.18916-100000@thoron.boston.redhat.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Morris <jmorris@redhat.com> wrote:
>
> On Mon, 20 Jun 2005, Andrew Morton wrote:
> 
> > I'll be looking for things to drop, too - it's getting a bit crazy.
> 
> Any reason to keep the Netlink connector code?
> 

Well it does fill a gap: something which presents a higher-level interface
to netlink capabilities.  There are several places in the kernel which do
open-coded hand-rolled netlink communications, so regularisation and
consolidation is a good thing there, if it's possible.

But the current connector implementation does that in an unpopular manner,
so we're a bit stuck.

