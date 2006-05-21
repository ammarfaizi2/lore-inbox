Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751531AbWEUMKA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751531AbWEUMKA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 08:10:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751534AbWEUMJ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 08:09:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:65183 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751531AbWEUMJ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 08:09:59 -0400
Date: Sun, 21 May 2006 05:09:51 -0700
From: Andrew Morton <akpm@osdl.org>
To: Chris Wedgwood <cw@f00f.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: + x86-move-vsyscall-page-out-of-fixmap-above-stack-tidy.patch
 added to -mm tree
Message-Id: <20060521050951.027b9dab.akpm@osdl.org>
In-Reply-To: <20060521110609.GA8322@taniwha.stupidest.org>
References: <200605210951.k4L9pwHq023019@shell0.pdx.osdl.net>
	<20060521110609.GA8322@taniwha.stupidest.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood <cw@f00f.org> wrote:
>
> On Sun, May 21, 2006 at 02:51:54AM -0700, akpm@osdl.org wrote:
> 
> > -	if ((ret = insert_vm_struct(mm, vma))) {
> > +	ret = insert_vm_struct(mm, vma);
> > +	if (ret) {
> 
> Urgh.
> 
> It's not really any cleaner/clearer so why do that?
>

Because it's cleaner and clearer and because Linus said.

One is an assignment and the other is a test.  These have nothing to do
with each other.

Keep it simple.
